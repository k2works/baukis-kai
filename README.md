Baukis 改
===================
[![CircleCI Build Status](https://circleci.com/gh/circleci/circleci-docs.svg?style=shield)](https://circleci.com/gh/k2works/baukis-kai) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/k2works/baukis-kai/master/MIT-LICENSE.txt)

# 目的 #
[実践Ruby on Rails 4 現場のプロから学ぶ本格Webプログラミング](https://www.amazon.co.jp/%E5%AE%9F%E8%B7%B5Ruby-Rails-4-%E7%8F%BE%E5%A0%B4%E3%81%AE%E3%83%97%E3%83%AD%E3%81%8B%E3%82%89%E5%AD%A6%E3%81%B6%E6%9C%AC%E6%A0%BCWeb%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0-%E9%BB%92%E7%94%B0/dp/4844335928)をRails5での実装及びフロント部分にモダンCSS設計(BEM)を組み込む

# 前提 #
| ソフトウェア   | バージョン   | 備考        |
|:---------------|:-------------|:------------|
| ruby           |2.4.0    |             |
| rails          |5.0.1    |             |
| vagrant        |1.8.7    |             |
| docker         |1.12.5    |             |
| docker-compose |1.8.0    |             |

# 構成 #
1. [アプリケーション環境構築](#アプリケーション環境構築)
   1. [Vagarntのセットアップ](#Vagarntのセットアップ)
   1. [Dockerのセットアップ](#Dockerのセットアップ)
   1. [追加Gemセットアップ](#追加Gemセットアップ)
   1. [その他の準備作業](#その他の準備作業)
   1. [テスト環境のセットアップ](#テスト環境のセットアップ)
1. [アプリケーション配置](#アプリケーション配置)
   1. [Herokuセットアップ](#Herokuセットアップ)
   1. [CircleCIセットアップ](#CircleCIセットアップ)
1. [アプリケーション開発](#アプリケーション開発)
   1. [ビジュアルデザイン](#ビジュアルデザイン)
   1. [エラーページ](#エラーページ)
   1. [ユーザー認証(1)](#ユーザー認証(1))
   1. [ユーザー認証(2)](#ユーザー認証(2))
   1. [ルーティング](#ルーティング)
   1. [レコードの表示、新規作成、更新、削除](#レコードの表示、新規作成、更新、削除)
   1. [String Parameters](#String Parameters])
   1. [アクセス制御](#アクセス制御)
   1. [モデル間の関連付け](#モデル間の関連付け)
   1. [値の正規化とバリデーション](#値の正規化とバリデーション)
   1. [プレゼンター](#プレゼンター)
   1. [jQueryとCoffeeScript](#jQueryとCoffeeScript)
   1. [単一テーブ継承](#単一テーブ継承)
   1. [Capybra](#Capybara)
   1. [フォームオブジェクト](#フォームオブジェクト)
   1. [検索フォーム](#検索フォーム)

## アプリケーション環境構築
### Vagarntのセットアップ
```
vagrant up
vagrant ssh
```

### Dockerのセットアップ
```
cd /vagrant/
docker-compose build
```

### 追加Gemセットアップ

### その他の準備作業
+ ライセンス文書の作成
+ タイムゾーンとロケールの設定
+ ジェネレータの設定
+ アプリケーション実行URLの設定

### テスト環境のセットアップ
+ RSpecの初期設定
+ Factory Girlの初期設定

**[⬆ back to top](#構成)**

## アプリケーション配置

### Herokuセットアップ
```bash
heroku create baukis-kai
git push heroku master
```

### CircleCIセットアップ

**[⬆ back to top](#構成)**
## アプリケーション開発
### ビジュアルデザイン
#### 仮設トップページ
+ ルーティングの設定
+ コントローラとアクションの作成
+ ERBテンプレートの作成
+ レイアウト
+ 部分テンプレート
+ ヘルパーメソッドの定義

### エラーページ
### ユーザー認証
### ユーザー認証
### ルーティング
### レコードの表示、新規作成、更新、削除
### String Parameters
### アクセス制御
### モデル間の関連付け
### 値の正規化とバリデーション
### プレゼンター
### jQueryとCoffeeScript
### 単一テーブ継承
### Capybara
### フォームオブジェクト
### 検索フォーム
**[⬆ back to top](#構成)**

# 参照 #
+ [実践Ruby on Rails 4 現場のプロから学ぶ本格Webプログラミング](https://www.amazon.co.jp/%E5%AE%9F%E8%B7%B5Ruby-Rails-4-%E7%8F%BE%E5%A0%B4%E3%81%AE%E3%83%97%E3%83%AD%E3%81%8B%E3%82%89%E5%AD%A6%E3%81%B6%E6%9C%AC%E6%A0%BCWeb%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0-%E9%BB%92%E7%94%B0/dp/4844335928)
