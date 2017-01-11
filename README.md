Baukis 改
===================
[![CircleCI Build Status](https://circleci.com/gh/circleci/circleci-docs.svg?style=shield)](https://circleci.com/gh/k2works/baukis-kai) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/k2works/baukis-kai/master/MIT-LICENSE.txt) 

# 目的 #

# 前提 #
| ソフトウェア   | バージョン   | 備考        |
|:---------------|:-------------|:------------|
| ruby           |2.4.0    |             |
| rails          |5.0.1    |             |
| vagrant        |1.8.7    |             |
| docker         |1.12.5    |             |
| docker-compose |1.8.0    |             |

# 構成 #
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

## アプリケーション配置

### Herokuセットアップ
```bash
heroku create baukis-kai
git push heroku master
```

### CircleCIセットアップ

## アプリケーション開発

# 参照 #

