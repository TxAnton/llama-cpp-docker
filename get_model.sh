#!/bin/sh

set -eu

# download model if specified as argument and exit
if [ "$#" -eq 1 ]; then
    if [ "$1" = "llama-2-13b" ]; then
        MODEL_URL="https://huggingface.co/TheBloke/Llama-2-13B-chat-GGUF/resolve/main/llama-2-13b-chat.Q5_K_M.gguf"
        MODEL_SHA256="ef36e090240040f97325758c1ad8e23f3801466a8eece3a9eac2d22d942f548a"
    elif [ "$1" = "mistral-7b" ]; then
        MODEL_URL="https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.2-GGUF/resolve/main/mistral-7b-instruct-v0.2.Q5_K_M.gguf"
        MODEL_SHA256="b85cdd596ddd76f3194047b9108a73c74d77ba04bef49255a50fc0cfbda83d32"
    elif [ "$1" = "solar-10b" ]; then
        MODEL_URL="https://huggingface.co/TheBloke/SOLAR-10.7B-Instruct-v1.0-GGUF/resolve/main/solar-10.7b-instruct-v1.0.Q5_K_M.gguf"
        MODEL_SHA256="4ade240f5dcc253272158f3659a56f5b1da8405510707476d23a7df943aa35f7"
    else
        echo "$0 [llama-2-13b|mistral-7b|solar-10b]"
        exit 1
    fi
    MODEL_NAME=$(basename "$MODEL_URL")
    curl -LO "$MODEL_URL"
    echo "$MODEL_SHA256  $MODEL_NAME" | sha256sum -c -
    exit 0
else
    echo "Usage: \t`basename $0` <llama-2-13b|mistral-7b|solar-10b>"
fi
