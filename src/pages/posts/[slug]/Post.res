// NOTE: 
// https://nextjs.org/docs/pages/building-your-application/routing/dynamic-routes

// On a dynamic route you should be able to access the slug via:
// import { useRouter } from 'next/router';
 
// export default function Page() {
//   const router = useRouter();
//   return <p>Post: {router.query.slug}</p>;
// }

type props = {
  msg: string,
  href: string,
}

let default = (props: props) => {
    let router = Next.Router.useRouter()
    let slug = Js.Dict.get(router.query, "slug")->Belt.Option.getUnsafe

    <div>
        {React.string(props.msg)}
        <a href=props.href target="_blank"> {React.string(`'/post/[${slug}] [slug].res'`)} </a>
    </div>
}

let getServerSideProps = _ctx => {
  let props = {
    msg: "Post [slug] Page: ",
    href: "https://github.com/ryyppy/nextjs-default/tree/master/src/Examples.res",
  }
  Js.Promise.resolve({"props": props})
}
