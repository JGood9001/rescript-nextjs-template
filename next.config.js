const bsconfig = require('./bsconfig.json');
const fs = require("fs");

// Fails to run the dev server with this line uncommented.
// And removing it fixes that + the prod build works fine.
// const transpileModules = ["rescript"].concat(bsconfig["bs-dependencies"]);
const transpileModules = []
const withTM = require("next-transpile-modules")(transpileModules);

// https://nextjs.org/blog/markdown
// syntax highlighting:
// https://v0.mdxjs.com/guides/syntax-highlighting
const withMDX = require('@next/mdx')({
  extension: /\.mdx?$/,
  options: {
    // If you use remark-gfm, you'll need to use next.config.mjs
    // as the package is ESM only
    // https://github.com/remarkjs/remark-gfm#install
    remarkPlugins: [require("remark-prism")],
    rehypePlugins: [],
    // If you use `MDXProvider`, uncomment the following line.
    // providerImportSource: "@mdx-js/react",
  },
});

const isWebpack5 = true;
const config = {
  // target: "serverless", deprecated https://nextjs.org/docs/messages/deprecated-target-config
  pageExtensions: ["jsx", "js", "mdx"],
  env: {
    ENV: process.env.NODE_ENV,
  },
  webpack: (config, options) => {
    const { isServer } = options;

    if (isWebpack5) {
      if (!isServer) {
        // We shim fs for things like the blog slugs component
        // where we need fs access in the server-side part
        config.resolve.fallback = {
          fs: false,
          path: false,
        };
      }

      // We need this additional rule to make sure that mjs files are
      // correctly detected within our src/ folder
      config.module.rules.push({
        test: /\.m?js$/,
        use: options.defaultLoaders.babel,
        exclude: /node_modules/,
        type: "javascript/auto",
        resolve: {
          fullySpecified: false,
        }
      });
    }
    return config
  },
  // - warn
  // The root value has an unexpected property, future, which is not in the list of allowed properties:
  // (amp, analyticsId, assetPrefix, basePath, cleanDistDir, compiler, compress, configOrigin, crossOrigin,
  //  devIndicators, distDir, env, eslint, excludeDefaultMomentLocales, experimental, exportPathMap, generateBuildId,
  //  generateEtags, headers, httpAgentOptions, i18n, images, modularizeImports, onDemandEntries, optimizeFonts, output,
  //  outputFileTracing, pageExtensions, poweredByHeader, productionBrowserSourceMaps, publicRuntimeConfig, reactStrictMode,
  //  redirects, rewrites, sassOptions, serverRuntimeConfig, skipMiddlewareUrlNormalize, skipTrailingSlashRedirect,
  //  staticPageGenerationTimeout, swcMinify, target, trailingSlash, transpilePackages, typescript, useFileSystemPublicRoutes, webpack).
  // future: {
  //   webpack5: isWebpack5
  // }
};

// module.exports = withTM(config);
module.exports = withMDX(config);