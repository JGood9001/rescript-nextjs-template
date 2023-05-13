module Link = Next.Link

type props = {
  msg: string,
  href: string,
}

let default = (props: props) =>
  <div>
    <Link href="/posts/1"> {React.string("Post 1")} </Link>
    <Link href="/posts/2"> {React.string("Post 2")} </Link>
    {React.string(props.msg)}
    // <a href=props.href target="_blank"> {React.string("`src/Post [slug].res`")} </a>
  </div>

let getServerSideProps = _ctx => {
  let props = {
    msg: "Posts Page: ",
    href: "https://github.com/ryyppy/nextjs-default/tree/master/src/Examples.res",
  }
  Js.Promise.resolve({"props": props})
}
