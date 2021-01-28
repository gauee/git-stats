FROM alpine
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh && \
    apk add python3 && \
    apk add py3-pip && \
    pip install pygooglechart
COPY . /apps/git-stats