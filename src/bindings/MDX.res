// module Link = {
//   @module("next/link") @react.component
//   external make: (
//     ~href: string,
//     ~_as: string=?,
//     ~prefetch: bool=?,
//     ~replace: option<bool>=?,
//     ~shallow: option<bool>=?,
//     ~passHref: option<bool>=?,
//     ~children: React.element,
//   ) => React.element = "default"
// }

type code_props = {className: string, children: React.element}
type pre_props = {children: React.element}
type components = {
    code: code_props => React.element,
    pre: pre_props => React.element
}

module MDXProvider = {
  @module("@mdx-js/react") @react.component
  external make: (
    ~components: components,
    ~children: React.element,
  ) => React.element = "MDXProvider"
}