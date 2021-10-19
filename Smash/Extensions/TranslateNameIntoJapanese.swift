//
//  TranslateNameIntoJapanese.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/08/04.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

struct T {

    static func translateStageName(name: String) -> String {
        switch name {
        case "final":
            return "終点"
        case "battleField":
            return "戦場"
        case "smallBattleField":
            return "小戦場"
        case "pokemonStadium2":
            return "ポケ2"
        case "kalos":
            return "カロス"
        case "smashVille":
            return "スマ村"
        case "townAndCity":
            return "村と街"
        case "lylat":
            return "ライ"
        default:
            return ""
        }
    }

    static func translateFighterName(name: String) -> String {
        switch name {
        case "mario":
            return "マリオ"
        case "donkey_kong":
            return "ドンキーコング"
        case "link":
            return "リンク"
        case "samus":
            return "サムス"
        case "dark_samus":
            return "ダークサムス"
        case "yoshi":
            return "ヨッシー"
        case "kirby":
            return "カービー"
        case "fox":
            return "フォックス"
        case "pikachu":
            return "ピカチュウ"
        case "luigi":
            return "ルイージ"
        case "ness":
            return "ネス"
        case "captain_falcon":
            return "キャプテン・\nファルコン"
        case "jigglypuff":
            return "プリン"
        case "peach":
            return "ピーチ"
        case "daisy":
            return "デイジー"
        case "bowser":
            return "クッパ"
        case "ice_climber":
            return "アイスクライマー"
        case "sheik":
            return "シーク"
        case "zelda":
            return "ゼルダ"
        case "dr_mario":
            return "ドクターマリオ"
        case "pichu":
            return "ピチュー"
        case "falco":
            return "ファルコ"
        case "marth":
            return "マルス"
        case "lucina":
            return "ルキナ"
        case "young_link":
            return "こどもリンク"
        case "ganondorf":
            return "ガノンドロフ"
        case "mewtwo":
            return "ミュウツー"
        case "roy":
            return "ロイ"
        case "chrom":
            return "クロム"
        case "mr_game_and_watch":
            return "Mr.ゲーム&ウォッチ"
        case "meta_knight":
            return "メタナイト"
        case "pit":
            return "ピット"
        case "dark_pit":
            return "ブラックピット"
        case "zero_suit_samus":
            return "ゼロスーツサムス"
        case "wario":
            return "ワリオ"
        case "snake":
            return "スネーク"
        case "ike":
            return "アイク"
        case "pt_squirtle":
            return "ゼニガメ"
        case "pt_ivysaur":
            return "フシギソウ"
        case "pt_charizard":
            return "リザードン"
        case "diddy_kong":
            return "ディディーコング"
        case "lucas":
            return "リュカ"
        case "sonic":
            return "ソニック"
        case "king_dedede":
            return "デデデ"
        case "olimar":
            return "ピクミン&オリマー"
        case "lucario":
            return "ルカリオ"
        case "rob":
            return "ロボット"
        case "toon_link":
            return "トゥーンリンク"
        case "wolf":
            return "ウルフ"
        case "villager":
            return "むらびと"
        case "mega_man":
            return "ロックマン"
        case "wii_fit_trainer":
            return "Wii Fit トレーナー"
        case "rosalina_and_luma":
            return "ロゼッタ&チコ"
        case "little_mac":
            return "リトル・マック"
        case "greninja":
            return "ゲッコウガ"
        case "palutena":
            return "パルテナ"
        case "pac_man":
            return "パックマン"
        case "robin":
            return "ルフレ"
        case "shulk":
            return "シュルク"
        case "bowser_jr":
            return "クッパJr."
        case "duck_hunt":
            return "ダックハント"
        case "ryu":
            return "リュウ"
        case "ken":
            return "ケン"
        case "cloud":
            return "クラウド"
        case "corrin":
            return "カムイ"
        case "bayonetta":
            return "ベヨネッタ"
        case "inkling":
            return "インクリング"
        case "ridley":
            return "リドリー"
        case "simon":
            return "シモン"
        case "richter":
            return "リヒター"
        case "king_k_rool":
            return "キングクルール"
        case "isabelle":
            return "しずえ"
        case "incineroar":
            return "ガオガエン"
        case "piranha_plant":
            return "パックンフラワー"
        case "joker":
            return "ジョーカー"
        case "hero":
            return "勇者"
        case "banjo_and_kazooie":
            return "バンジョー&カズーイ"
        case "terry":
            return "テリー"
        case "byleth":
            return "べレト/べレス"
        case "minmin":
            return "ミェンミェン"
        case "steve":
            return "スティーブ"
        case "sephiroth":
            return "セフィロス"
        case "mythra":
            return "ホムラ/ヒカリ"
        case "kazuya":
            return "カズヤ"
        case "sora":
            return "ソラ"
        case "mii_brawler":
            return "格闘Mii"
        case "mii_gunner":
            return "射撃Mii"
        case "mii_swordfighter":
            return "剣術Mii"
        default:
            return ""
        }
    }

//    static func translateFrameFighterName(name: String) -> String {
//        switch name {
//        case "mario":
//            return "MARIO"
//        case "donkey_kong":
//            return "DONKEY KONG"
//        case "link":
//            return "LINK"
//        case "samus":
//            return "SAMUS"
//        case "dark_samus":
//            return "DARK SAMUS"
//        case "yoshi":
//            return "YOSHI"
//        case "kirby":
//            return "KIRBY"
//        case "fox":
//            return "FOX"
//        case "pikachu":
//            return "PIKACHU"
//        case "luigi":
//            return "LUIGI"
//        case "ness":
//            return "NESS"
//        case "captain_falcon":
//            return "CAPTAIN FALCON"
//        case "jigglypuff":
//            return "PURIN"
//        case "peach":
//            return "PEACH"
//        case "daisy":
//            return "DAISY"
//        case "bowser":
//            return "KOOPA"
//        case "ice_climber":
//            return "ICE CLIMBER"
//        case "sheik":
//            return "SHEIK"
//        case "zelda":
//            return "ZELDA"
//        case "dr_mario":
//            return "Dr MARIO"
//        case "pichu":
//            return "PICHU"
//        case "falco":
//            return "FALCO"
//        case "marth":
//            return "MARTH"
//        case "lucina":
//            return "LUCINA"
//        case "young_link":
//            return "YOUNG LINKリンク"
//        case "ganondorf":
//            return "GANONDROF"
//        case "mewtwo":
//            return "MEWTWO"
//        case "roy":
//            return "ROY"
//        case "chrom":
//            return "CHROM"
//        case "mr_game_and_watch":
//            return "Mr. GAME & WATCH"
//        case "meta_knight":
//            return "META KNIGHT"
//        case "pit":
//            return "PIT"
//        case "dark_pit":
//            return "BLACK PIT"
//        case "zero_suit_samus":
//            return "ZERO SUIT SAMUS"
//        case "wario":
//            return "WARIO"
//        case "snake":
//            return "SNAKE"
//        case "ike":
//            return "IKE"
//        case "pt_squirtle":
//            return "ZENIGAME"
//        case "pt_ivysaur":
//            return "HUSHIGISOU"
//        case "pt_charizard":
//            return "RIZARDON"
//        case "diddy_kong":
//            return "DODOY KONG"
//        case "lucas":
//            return "LUCAS"
//        case "sonic":
//            return "SONIC"
//        case "king_dedede":
//            return "DEDEDE"
//        case "olimar":
//            return "PIKMIN & OKIMER"
//        case "lucario":
//            return "LUCARIO"
//        case "rob":
//            return "ROBOT"
//        case "toon_link":
//            return "TOONLINK"
//        case "wolf":
//            return "WOLF"
//        case "villager":
//            return "MURABITO"
//        case "mega_man":
//            return "ROCKMAN"
//        case "wii_fit_trainer":
//            return "WII FIT TRAINER"
//        case "rosalina_and_luma":
//            return "ROSSETA & CHIKO"
//        case "little_mac":
//            return "LITTLE MAC"
//        case "greninja":
//            return "GEKKOUGA"
//        case "palutena":
//            return "PALUTENA"
//        case "pac_man":
//            return "PAC MAN"
//        case "robin":
//            return "REFLET"
//        case "shulk":
//            return "SHULK"
//        case "bowser_jr":
//            return "KOOPA Jr."
//        case "duck_hunt":
//            return "DUCK HUNT"
//        case "ryu":
//            return "RYU"
//        case "ken":
//            return "KEN"
//        case "cloud":
//            return "CLOUD"
//        case "corrin":
//            return "KAMUI"
//        case "bayonetta":
//            return "BEONETTA"
//        case "inkling":
//            return "INKLING"
//        case "ridley":
//            return "RIDLEY"
//        case "simon":
//            return "SIMON"
//        case "richter":
//            return "RICHTER"
//        case "king_k_rool":
//            return "KING K. ROOL"
//        case "isabelle":
//            return "SHIZUE"
//        case "incineroar":
//            return "GAOGAEN"
//        case "piranha_plant":
//            return "PACKUN FLOWER"
//        case "joker":
//            return "JOKER"
//        case "hero":
//            return "HERO"
//        case "banjo_and_kazooie":
//            return "BANJO & KAZOOIE"
//        case "terry":
//            return "TERRY"
//        case "byleth":
//            return "BYLETH"
//        case "minmin":
//            return "MINMIN"
//        case "steve":
//            return "STEVE"
//        
//        case "mii_brawler":
//            return "BRAWLER"
//        case "mii_gunner":
//            return "GANNER"
//        case "mii_swordfighter":
//            return "SWORD"
//        default:
//            return ""
//        }
//    }

}

