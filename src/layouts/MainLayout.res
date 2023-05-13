module Link = Next.Link
module Head = Next.Head

module Navigation = {
  @react.component
  let make = () => <>
    <Head>
      <link
        rel="stylesheet"
        href="https://unpkg.com/dracula-prism/dist/css/dracula-prism.css"
      ></link>
    </Head>
    <nav className="p-2 h-12 flex border-b border-gray-200 justify-between items-center text-sm">
      <Link href="/">
          <img className="w-5" src="/static/zeit-black-triangle.svg" />
          <span className="text-xl ml-2 align-middle font-semibold">
            {React.string("Next")} <span className="text-orange-800"> {React.string(" + ReScript")} </span>
          </span>
      </Link>
      <div className="flex w-2/3 justify-end">
        <Link href="/"> {React.string("Home")} </Link>
        <Link href="/about"> {React.string("About")} </Link>
        <Link href="/posts"> {React.string("Posts")} </Link>
        // Link with embedded a tag is deprecated
        // <Link href="/examples"> <a className="px-3"> {React.string("Examples")} </a> </Link>
        <a
          className="px-3 font-bold"
          target="_blank"
          href="https://github.com/ryyppy/nextjs-default">
          {React.string("Github")}
        </a>
      </div>
    </nav>
    </>
}

@react.component
let make = (~children) => {
  let minWidth = ReactDOM.Style.make(~minWidth="20rem", ())
  <div style=minWidth className="flex lg:justify-center">
    <div className="max-w-5xl w-full lg:w-3/4 text-gray-900 font-base">
      <Navigation /> <main className="mt-4 mx-4"> children </main>
    </div>
  </div>
}
