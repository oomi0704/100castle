# Ruby 3.3.0を使用
FROM ruby:3.3.0-alpine

# 必要なパッケージをインストール
RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    postgresql-client \
    tzdata \
    nodejs \
    npm \
    git

# 作業ディレクトリを設定
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# Bundlerをインストール
RUN gem install bundler

# 依存関係をインストール
RUN bundle install

# アプリケーションのソースコードをコピー
COPY . .

# アセットをプリコンパイル
RUN bundle exec rails assets:precompile

# ポート3000を公開
EXPOSE 3000

# 起動コマンド
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
