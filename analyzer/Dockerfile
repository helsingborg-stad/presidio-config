FROM mcr.microsoft.com/presidio-analyzer:latest

RUN pip install --no-cache-dir "presidio-analyzer[transformers]" spacy-huggingface-pipelines

RUN python -m spacy download sv_core_news_sm

RUN python -c "from transformers import AutoTokenizer, AutoModelForTokenClassification; \
    AutoTokenizer.from_pretrained('KB/bert-base-swedish-cased-ner'); \
    AutoModelForTokenClassification.from_pretrained('KB/bert-base-swedish-cased-ner')"

COPY nlp_config.yaml /etc/presidio/nlp_config.yaml
COPY recognizers.yaml /etc/presidio/recognizers.yaml
COPY analyzer_config.yaml /etc/presidio/analyzer_config.yaml
ENV NLP_CONF_FILE=/etc/presidio/nlp_config.yaml
ENV RECOGNIZER_REGISTRY_CONF_FILE=/etc/presidio/recognizers.yaml
ENV ANALYZER_CONF_FILE=/etc/presidio/analyzer_config.yaml
