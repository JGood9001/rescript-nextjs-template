module Link = Next.Link

open NodeJs
// This type signature works too though, differing from what the NodeJs bindings defined it as -> https://github.com/TheSpyder/rescript-nodejs/blob/main/src/Process.res#L118
// @module("process") external cwd: () => string = "cwd"
type gray_matter_data = { "title": string, "slug": string, "description": string, "date": string }
type gray_matter_content = { "content": string, "data": gray_matter_data }

// https://willcodefor.beer/posts/rescript-ffi-basics-in-react/
@module("gray-matter") external matter: string => gray_matter_content = "default"

@module("fs") external readFileSync: string => string => string = "readFileSync"

type props = {
  posts: array<string>
}

let default = (props: props) => {
  (
    <div>
      <Link href="/posts/1"> {React.string("Post 1")} </Link>
      <Link href="/posts/2"> {React.string("Post 2")} </Link>
      <div>{React.string(Js.Json.stringifyAny(props.posts)->Belt.Option.getUnsafe)}</div>
    </div>
  )
}

// path.join -> https://github.com/TheSpyder/rescript-nodejs/blob/main/src/Path.res#L24
// type processt 
// @module external process: processt = "process"
// @module("process") external cwd: () => string = "cwd"
// process.cwd -> https://github.com/TheSpyder/rescript-nodejs/blob/main/src/Process.res#L118
// fs.readdirSync -> https://github.com/TheSpyder/rescript-nodejs/blob/main/src/Fs.res#L224
type filename_and_matter = { filename: string, matter: gray_matter_content }

// NOTE:
// Attempted to use resrepl in the context of this project, and all Js.logs result in build + evaluation (as the js file is appended
// to and the contents removed), but it fails because bsconfig.json specifies suffix for compiled js files to be "suffix": ".mjs", instead
// of using bs.js.
// https://github.com/JGood9001/rescript-repl/blob/main/src/repl-logic/REPLLogic.res#L34
let getStaticProps = (_ctx) => {
  let posts_directory = NodeJs.Path.join([NodeJs.Process.cwd(NodeJs.Process.process), "pages/posts"])
  let filenames = Js.Array.filter(x => Js.String.split(".", x)[1] !== "js", NodeJs.Fs.readdirSync(posts_directory)) // => [ 'index.js', 'my-mdx-page.mdx' ]

  let files = Js.Promise.all(filenames->Belt.Array.map(filename => {
    let filepath = NodeJs.Path.join([posts_directory, filename])
    let content = readFileSync(filepath, "utf8")
    let matter: gray_matter_content = matter(content)
    let x = { "filename": filename, "matter": matter }
    Js.Promise.resolve(x)
  }))

  Js.Promise.then_(xs => {
    let ys = xs->Belt.Array.map(x => ({
      "path": `/posts/${x["matter"]["data"]["slug"]}`,
      "title": x["matter"]["data"]["title"]
    }))
    Js.Promise.resolve({ "props": { "posts": ys } })
  }, files)
}
