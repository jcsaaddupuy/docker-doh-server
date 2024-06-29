#! /usr/bin/env bash
set -e
set -u
set -o pipefail

# see https://developers.cloudflare.com/1.1.1.1/encryption/dns-over-https/make-api-requests/dns-wireformat/
DOH_PROXY_HOST=${DOH_PROXY_HOST:-127.0.0.1:3000}
{
echo -n 'q80BAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB' \
	| base64 --decode \
	| curl \
		-s --fail \
		-H 'content-type: application/dns-message' \
		--data-binary @- http://${DOH_PROXY_HOST}/dns-query -o - >> /dev/null 
}|| exit 1

echo "Ok"
