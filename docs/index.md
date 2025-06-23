# Baukis 改 (Baukis Kai)

[![GitHub Actions](https://github.com/k2works/baukis-kai/actions/workflows/CI.yml/badge.svg)](https://github.com/k2works/baukis-kai/actions) [![Code Climate](https://codeclimate.com/github/k2works/baukis-kai/badges/gpa.svg)](https://codeclimate.com/github/k2works/baukis-kai) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/k2works/baukis-kai/master/MIT-LICENSE.txt)

## プロジェクト概要

Baukis 改は、書籍「実践Ruby on Rails 4 現場のプロから学ぶ本格Webプログラミング」をベースにした顧客管理システムです。本プロジェクトでは、元の実装をRails 5からRails 7へアップグレードし、フロントエンド部分にモダンCSS設計（BEM）を組み込んでいます。

## 背景

このプロジェクトは、実践的なRuby on Railsの学習と、最新のWeb開発技術の適用を目的としています。書籍の内容をベースにしながらも、最新のRailsバージョンへの対応や、モダンなフロントエンド設計手法の導入により、より実践的で現代的なWebアプリケーション開発の知識を深めることができます。

## 主な機能

- 職員、管理者、顧客の3種類のユーザー区分
- 顧客情報の管理（検索、表示、追加、更新、削除）
- プログラム管理と申し込み機能
- 問い合わせ管理システム
- ユーザー認証とアクセス制御

## 技術スタック

| ソフトウェア | バージョン | 備考 |
|:------------|:---------|:-----|
| Ruby        | 3.4.4    |      |
| Rails       | 7.2.2.1  |      |
| Docker      | 28.1.1   |      |

## クイックスタート

```bash
docker build -t app:base .
docker compose build
docker compose up -d
```

http://127.0.0.1:3000 にアクセスして、アプリケーションが起動していることを確認してください。

## プロジェクト構成

プロジェクトは以下の主要なセクションで構成されています：

1. 仕様（基本仕様、ユースケース、コアモデル）
2. アプリケーション環境構築
3. アプリケーション配置
4. アプリケーション開発（ビジュアルデザイン、認証、ルーティングなど）

## まずこれを読もうリスト

- [コンテキスト図]() - 情勢をつかむ。
- [インセプションデッキ]() - プロジェクトの最初の週に作成された。ここにあるものの大部分は変更されたが、このドキュメントは我々がなぜこのシステムを構築しているかを示している。
- [ユースケース](ユースケース.md) - システムの機能を表す。システムが何をするかを理解するのに必要。
- [アーキテクチャドキュメント](アーキテクチャ概要.md) - システムのアーキテクチャを示す。システムの全体像を把握するために重要。
- [開発ドキュメント](アプリケーション実装.md) - 開発の具体的な手順やガイドラインをまとめる。
