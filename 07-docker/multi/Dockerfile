FROM golang:1.16 as build
RUN apt-get update && apt-get install -y curl git
WORKDIR /wcg
RUN git clone https://github.com/Fenikks/word-cloud-generator.git
RUN cd word-cloud-generator && make
CMD ["GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o ./wcg_app -v"]
COPY /wcg/word-cloud-generator/wcg_app ./wcg_app

FROM alpine:latest as production
WORKDIR /opt/wordcloud
# COPY --from=build /wcg/word-cloud-generator/wcg_app /opt/wordcloud/wcg_app
ADD ./word-cloud-generator /opt/wordcloud/wcg_app
ENTRYPOINT /opt/wordcloud/wcg_app
EXPOSE 8888