return {
  s(
    "newp",
    fmt(
      "new Promise{}(({}) => {{\n{}\n}})",
      { c(1, { sn(1, fmt("<{}>", { i(1, "void") })), t("") }), c(2, { t("resolve"), t("resolve, reject") }), i(0) }
    )
    -- fmt("new Promise<{}>(({}) => {{\n{}\n}})", { i(1, "void"), c(2, { t("resolve"), t("resolve, reject") }), i(0) })
  ),
  s(
    "event",
    fmta(
      [[class <>Event extends Event{
  constructor(type:string, options: <>EventInit) {
    super(type, options) 
  }
}

interface <>EventInit extends EventInit {
  <>
}]],
      { i(1), rep(1), rep(1), i(0) }
    )
  ),
  s(
    "eventmap",
    fmt(
      [[type {}EventMap = {{
  {}
}}

interface {} {{
  addEventListener<K extends keyof {}EventMap>(
    type: K,
    listener: (this: {}, ev: {}EventMap[K]) => unknown,
    options?: boolean | AddEventListenerOptions,
  ): void
  addEventListener(
    type: string,
    listener: EventListenerOrEventListenerObject,
    options?: boolean | AddEventListenerOptions,
  ): void
  removeEventListener<K extends keyof {}EventMap>(
    type: K,
    listener: (this: {}, ev: {}EventMap[K]) => unknown,
    options?: boolean | AddEventListenerOptions,
  ): void
  removeEventListener(
    type: string,
    listener: EventListenerOrEventListenerObject,
    options?: boolean | AddEventListenerOptions,
  ): void
}}

]],
      { i(1), i(0), rep(1), rep(1), rep(1), rep(1), rep(1), rep(1), rep(1) }
    )
  ),
}
