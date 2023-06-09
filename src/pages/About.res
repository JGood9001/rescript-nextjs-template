type props = {
  msg: string,
  href: string,
}

let default = (props: props) =>
  <div>
    {React.string(props.msg)}
    <a href=props.href target="_blank"> {React.string("`src/About.res`")} </a>
  </div>

let getServerSideProps = _ctx => {
  let props = {
    msg: "This page was rendered with getServerSideProps. About Page: ",
    href: "https://github.com/ryyppy/nextjs-default/tree/master/src/Examples.res",
  }
  Js.Promise.resolve({"props": props})
}
