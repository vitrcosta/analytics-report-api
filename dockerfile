FROM ruby:3.1.2

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler:2.2.28
RUN bundle install

COPY . .

# Expõe a porta 3000 para acesso externo
EXPOSE 3000

# Define o comando de inicialização do contêiner
CMD ["rails", "server", "-b", "0.0.0.0"]