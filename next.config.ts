import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: 'export',
  images: {
    unoptimized: true
  },
  basePath: '/leadpilot',
  assetPrefix: '/leadpilot/'
};

export default nextConfig;
