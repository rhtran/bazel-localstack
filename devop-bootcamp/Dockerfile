FROM localstack/localstack:latest

COPY /etc/.ssl/ca-certificates.pem /usr/local/share/ca-certificates/cert-bundle.crt
RUN update-ca-certificates
ENV CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
ENV REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt