require("stroiman.plugins").load("gp")
local gp = require("gp")

gp.setup({
  providers = {
    openai = {
      endpoint = "https://api.openai.com/v1/chat/completions",
      secret = "dummy", --os.getenv("OPENAI_API_KEY"),
    },
    ollama = {
      endpoint = "http://localhost:11434/v1/chat/completions",
    },
  },
  agents = {
    {
      name = "Llama3.2",
      chat = true,
      command = true,
      provider = "ollama",
      model = { model = "llama3.2" },
      system_prompt = "I am an AI meticulously crafted to provide programming guidance and code assistance. "
        .. "To best serve you as a computer programmer, please provide detailed inquiries and code snippets when necessary, "
        .. "and expect precise, technical responses tailored to your development needs.\n",
    },
  },
  hooks = {
    -- example of usig enew as a function specifying type for the new buffer
    --     UnitTests = function(gp, params)
    --     local template = "I have the following code from {{filename}}:\n\n"
    --         .. "```{{filetype}}\n{{selection}}\n```\n\n"
    --         .. "Please respond by writing table driven unit tests for the code above."
    --     local agent = gp.get_command_agent()
    --     gp.Prompt(params, gp.Target.vnew, agent, template)
    -- end,

    CodeReview = function(gp, params)
      local template = "I have the following code from {{filename}}:\n\n"
        .. "```{{filetype}}\n{{selection}}\n```\n\n"
        .. "Please analyze for code smells and suggest improvements."
      local agent = gp.get_chat_agent()
      -- gp.Prompt(params, gp.Target.enew("markdown"), nil, agent.model, template, agent.system_prompt)
      gp.Prompt(params, gp.Target.enew("markdown"), agent, template)
    end,
    -- example of adding command which explains the selected code
    Explain = function(gp, params)
      local template = "I have the following code from {{filename}}:\n\n"
        .. "```{{filetype}}\n{{selection}}\n```\n\n"
        .. "Please respond by explaining the code above."
      local agent = gp.get_chat_agent()
      gp.Prompt(params, gp.Target.popup, agent, template)
    end,
    -- example of making :%GpChatNew a dedicated command which
    -- opens new chat with the entire current buffer as a context
    BufferChatNew = function(gp, _)
      -- call GpChatNew command in range mode on whole buffer
      vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
    end,
  },
})
