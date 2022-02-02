FROM node:16-slim

RUN apt-get update \
    && apt-get install -y chromium fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && apt-get -q -y clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
COPY package.json yarn.lock /aws-azure-login/

RUN cd /aws-azure-login \
   && yarn install --production

RUN ln -s /usr/bin/chromium /usr/bin/chromium-browser

COPY lib /aws-azure-login/lib

ENTRYPOINT ["node", "/aws-azure-login/lib", "--no-sandbox"]
