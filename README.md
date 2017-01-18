Baukis 改
===================
[![CircleCI Build Status](https://circleci.com/gh/circleci/circleci-docs.svg?style=shield)](https://circleci.com/gh/k2works/baukis-kai) [![Code Climate](https://codeclimate.com/github/k2works/baukis-kai/badges/gpa.svg)](https://codeclimate.com/github/k2works/baukis-kai) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/k2works/baukis-kai/master/MIT-LICENSE.txt)

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

#### Sass/SCSS
+ アセットパイプライン
+ Sass/SCSSとは
+ スタイルシートの切り替え
+ ヘッダとフッタのスタイル
+ 見出し(h1要素)のスタイル
+ 色を変数で表現する
+ 寸法を変数で表現する
+ アセットのプリコンパイル

## よいCSSを書くためのHTMLマークアップ-CSS設計-
### デザインカンプを確認し、CSS設計を理解しよう
#### コンポーネント
+ ヘッダー
+ カルーセル
+ サムネイル画像付きコンテンツ
+ オーバーレイパネル
+ アイコン付きコンテンツ
+ ニュースリスト
+ フッター

#### CSS設計
+ BEM
+ [OOCSS](http://oocss.org/)
+ [MCSS](http://operatino.github.io/MCSS/ja/)
+ [SMACSS](https://smacss.com/)

#### BEM
 + [BEM](https://en.bem.info/)
 + [MindBEMding](http://csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/)
 
#### classの命名規則について
+ Blockの最初の文字は大文字で書くこと
+ Elementの最初の文字は小文字で書く
+ BlockとElementは「__」でつなぐ
+ Modifierをつける場合は「--」でつなぐ

#### まとめ
 1. 最初は「見た目」からコンポーネントを割り出す
 1. 大文字や小文字などをうまく使い分ける
 1. 長いclass名はエディタの保管機能を使えば怖くない

### サイト制作の下準備をしよう

#### indexページ作成

#### フォルダを整理する

#### 分割したファイルを読み込む「import機能」

#### リセットCSSを導入する

#### 背景色を設定する

#### まとめ
+ どんなサイトを作る場合でも、まずリセットCSSを導入する
+ コンポーネントごとにファイルを分けて、一覧できるようにする
+ 変数は、変数だけのファイルを作成すると管理が楽になって効率的

### Headerを作成しよう

#### コンポーネントを意識してマークアップしよう

#### HTMLをマークアップ

#### まとめ
+ コンポーネントを、まずはBlockとして作ってみる
+ 複雑なコンポーネントはBlockの中にBlockを作ってみる
+ Elementは汎用的な命名をなるべく使い、どこのBlockに属するのかをわかりやすくする

## Sassを使ったサイト制作 その１（ヘッダーなど）

### ヘッダーのスタイルを作成しよう

#### Flexを利用したヘッダーのCSS  

#### 「画像+記事」のコンポーネントを作る

#### ボタンを作成する

#### まとめ
+ レイアウトは極力Flexを使って書く
+ Flexのショートハンドの書き方に慣れる
+ それ以上細かくできないコンポーネントはpartsとして作る

### レイアウトを作成しよう  
  
#### レイアウトを整えるCSSを作る

#### 全体的な幅を決める
#### まとめ
+ レイアウトについてはCSSからわかるように「l-」を付ける
+ レイアウトはコンポーネントではないのでpartsフォルダに作成する
+ Sassの四則演算を上手に使ってレイアウトを整える

## Sassを使ったサイト制作 その２（メインコンテンツやフッターなど）

### メインイメージを作成しよう
#### カルーセルを組み込むには

#### インジケータの制作 

#### JavaScriptを有効化する

#### まとめ
+ JavaScriptを読み込む位置は、bodyタグの終了タグの位置
+ JavaScriptと連携しているところは「js-」という接頭語をつける
+ 状態についてのCSSは「isXXX」という命名規則を使う

### コンテンツ部分を作成しよう

#### コンテンツ部の作成をはじめる

#### タイトル部分を作成する

#### OverlayPanelを作成する

#### 背景画像を設定する

#### アイコン付きのコンテンツメニューを作成する

#### ニュースのコンポーネントを作成する

#### まとめ
+ 疑似要素を使って、かしこくclassの指定をする
+ ページ専用の要素はコンポーネントとは別管理にする
+ 変数をセレクタで使える「インターポレーション」

### フッターを作成しよう

#### フッター作成を始める

#### Menuを修正する

### フォルダを整理しよう

#### これまで作成したもののおさらい

+ baseフォルダ                            
+ componentsフォルダ
+ commonフォルダ
+ pageフォルダ

#### まとめ
+ ただ作るのではなく、どのフォルダに属するのかを意識しながら作る
+ main.cssにコメントを残し、どういうファイルがあるかがひと目でわかるようにする

## プロらしく「魅せる」テクニック-トップページの総仕上げ-

### アイコンフォントを活用しよう

#### アイコンフォントを使う

#### まとめ
+ アイコンフォントと画像の違いを理解する
+ アイコンフォントは解像度に左右されない
+ FontAwesomeは便利なので、使い方をマスターする

### WebFontを利用しよう

#### WebFontを使うための準備

#### WebFontを使ってみよう

#### まとめ
+ WebFontはフォントの表現幅が大幅に上がる
+ WebFontをmixinとしておくことで、使いやすなる
+ WebFontを使いすぎるとパフォーマンスが下がるので注意する

### 突発的な修正に上手に対応しよう

#### 突発的な修正に上手に対応するには？

#### ユーティリティclassを作成する

#### まとめ
+ 汎用的なclassとわかるように「u-」の接頭辞をつける
+ 汎用的なclassを使ってうまくレイアウトを整える
+ コンポーネントの修正以外の視点を持つ

### Webページをレスポンシブ化しよう

#### mixinを作成する

#### 各コンポーネントのスマートフォン対応

#### まとめ
+ Media Queriesはレスポンシブの基本なので必ず覚える
+ @contentをうまく利用して、効率よくレスポンシブサイトを作成する
+ レスポンシブについてのCSSはmixinにして再利用可能にする

## パーツの組み合わせによる「高速」Webページ制作

### キャンペーンページを作成しよう

#### キャンペーンページのHTMLを確認する

#### 3つのコンテンツが並んでいるコンポーネントの制作

#### 横幅いっぱいの画像のコンポーネントと「アイコン+テキストコンポーネント」

#### フォームを作成する

#### まとめ
+ 新たに作るのではなく、すでに似たものを作っていないかという視点を持つ
+ 既存のコンポーネントを組み合わせて新たなページを作成する
+ Modifierを使ってデザインを調整する

### サイドバーのある画面を作ろう

#### Articleページを作成する

#### Flexを活用してサイドバーのあるレイアウトを作る

#### まとめ
+ Flexを使えば、面倒なサイドバーのレイアウトも簡単に
+ コンポーネントベースで作ると、ページ固有のCSSを少し追加するだけでほぼ１ページ作れる

### エラーページ
#### 例外処理の基礎知識
+ 例外とは
+ raiseメソッドと例外機構文
+ クラスメソッドrescue_from

#### 500 Internal Server Error
+ 準備作業
+ 例外の捕捉
+ ビジュアルデザイン

#### 403 Forbidden
+ 例外の捕捉
+ ERBテンプレートの作成
+ 動作の確認

#### 404 Not Found
+ 例外ActionController::RoutingErrorの処理
+ 例外ActiveRecord::RecordNotFoundの処理

#### ActiveSupport::Concern

### ユーザー認証(1)
#### マイグレーション
+ 各種スケルトンの作成
+ マイグレーションスクリプト
+ マイグレーションの実行
+ 主キー

#### モデル
#### セッション

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
+ [現場のプロが本気で教える HTML/CSSデザイン講義](https://www.amazon.co.jp/dp/B01K3SZGR0/ref=dp-kindle-redirect?_encoding=UTF8&btkr=1)
+ [現場のプロが本気で教える HTML/CSSデザイン講義 サンプルデータ](https://github.com/basara669/html_css_book)
+ [Bootstrap for Sass](https://github.com/twbs/bootstrap-sass)
+ [Rails Bootstrap Forms](https://github.com/bootstrap-ruby/rails-bootstrap-forms)
+ [Annotate (aka AnnotateModels)](https://github.com/ctran/annotate_models)
+ [MigrationComments](https://github.com/pinnymz/migration_comments)