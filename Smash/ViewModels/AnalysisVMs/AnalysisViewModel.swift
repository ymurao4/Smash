//
//  AnalysisViewModel.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class AnalysisViewModel: ObservableObject {

    @Published var analysisRepository = AnalysisRepository()
    @Published var totalRecord: [String] = ["total", "-", "-", "-", "-"]
    @Published var outputRecord: [[String]] = [
        ["mario", "-", "-", "-", "-"],
        ["donkey_kong", "-", "-", "-", "-"],
        ["link", "-", "-","-", "-"],
        ["samus", "-", "-", "-", "-"],
        ["dark_samus", "-", "-", "-", "-"],
        ["yoshi", "-", "-", "-", "-"],
        ["kirby", "-", "-", "-", "-"],
        ["fox", "-", "-", "-", "-"],
        ["pikachu", "-", "-", "-", "-"],
        ["luigi", "-", "-", "-", "-"],
        ["ness", "-", "-", "-", "-"],
        ["captain_falcon", "-", "-", "-", "-"],
        ["purin", "-", "-", "-", "-"],
        ["peach", "-", "-", "-", "-"],
        ["daisy", "-", "-", "-", "-"],
        ["koopa", "-", "-", "-", "-"],
        ["ice_climber", "-", "-", "-", "-"],
        ["sheik", "-", "-", "-", "-"],
        ["zelda", "-", "-", "-", "-"],
        ["dr_mario","-", "-", "-", "-"],
        ["pichu", "-", "-", "-", "-"],
        ["falco", "-", "-", "-", "-"],
        ["marth", "-", "-", "-", "-"],
        ["lucina", "-", "-", "-", "-"],
        ["young_link", "-", "-", "-", "-"],
        ["ganondorf", "-", "-", "-", "-"],
        ["mewtwo", "-", "-", "-", "-"],
        ["roy", "-", "-", "-", "-"],
        ["chrom", "-", "-", "-", "-"],
        ["mr_game_and_watch", "-", "-", "-", "-"],
        ["meta_knight", "-", "-", "-", "-"],
        ["pit", "-", "-", "-", "-"],
        ["black_pit", "-", "-", "-", "-"],
        ["zero_suit_samus", "-", "-", "-", "-"],
        ["wario", "-", "-", "-", "-"],
        ["snake", "-", "-", "-", "-"],
        ["ike", "-", "-", "-", "-"],
        ["pokemon_trainer", "-", "-", "-", "-"],
        ["diddy_kong", "-", "-", "-", "-"],
        ["lucas", "-", "-", "-", "-"],
        ["sonic", "-", "-", "-", "-"],
        ["dedede", "-", "-", "-", "-"],
        ["pikmin_and_olimar", "-", "-", "-", "-"],
        ["lucario", "-", "-", "-", "-"],
        ["robot", "-", "-", "-", "-"],
        ["toon_link", "-", "-", "-", "-"],
        ["wolf", "-", "-", "-", "-"],
        ["murabito", "-", "-", "-", "-"],
        ["rockman", "-", "-", "-", "-"],
        ["wii_fit_trainer", "-", "-", "-", "-"],
        ["rosetta_and_chiko", "-", "-", "-", "-"],
        ["little_mac", "-", "-", "-", "-"],
        ["gekkouga", "-", "-", "-", "-"],
        ["mii_fighter", "-", "-", "-", "-"],
        ["palutena", "-", "-", "-", "-"],
        ["pac_man", "-", "-", "-", "-"],
        ["reflet", "-", "-", "-", "-"],
        ["shulk", "-", "-", "-", "-"],
        ["koopa_jr", "-", "-", "-", "-"],
        ["duck_hunt", "-", "-", "-", "-"],
        ["ryu", "-", "-", "-", "-"],
        ["ken", "-", "-", "-", "-"],
        ["cloud", "-", "-", "-", "-"],
        ["kamui", "-", "-", "-", "-"],
        ["bayonetta", "-", "-", "-", "-"],
        ["inkling", "-", "-", "-", "-"],
        ["ridley", "-", "-", "-", "-"],
        ["simon", "-", "-", "-", "-"],
        ["richter", "-", "-", "-", "-"],
        ["king_k_rool", "-", "-", "-", "-"],
        ["shizue", "-", "-", "-", "-"],
        ["gaogaen", "-", "-", "-", "-"],
        ["packun_flower", "-", "-", "-", "-"],
        ["joker", "-", "-", "-", "-"],
        ["dq_hero", "-", "-", "-", "-"],
        ["banjo_and_kazooie", "-", "-", "-", "-"],
        ["terry", "-", "-", "-", "-"],
        ["byleth", "-", "-", "-", "-"],
        ["minmin", "-", "-", "-", "-"],
        ["steve", "-", "-", "-", "-"],
        ["sephiroth", "-", "-", "-", "-"],
        ["pyra", "-", "-", "-", "-"],
        ["kazuya", "-", "-", "-", "-"]
    ]
    @Published var outputStageRecord: [[String]] = [
        ["final", "-", "-", "-", "-"],
        ["battleField", "-", "-", "-", "-"],
        ["smallBattleField", "-", "-", "-", "-"],
        ["pokemonStadium2", "-", "-", "-", "-"],
        ["kalos", "-", "-", "-", "-"],
        ["smashVille", "-", "-", "-", "-"],
        ["townAndCity", "-", "-", "-", "-"],
        ["lylat", "-", "-", "-", "-"]
    ]
    @Published var isMain: Bool = false
    @Published var mainFighter = ""

    private var cancellables = Set<AnyCancellable>()

    private let userDefaults = UserDefaults.standard

    init(sortName: String) {

        loadMainFighter()

        // メイン以外のレコード
        analysisRepository.$records.sink { records in

            var resultRecords: [[Any]] = []

            for record in records {
                // メインキャラの分析時、メインキャラ以外のレコードはスキップ
                if self.isMain {

                    if record.myFighter != self.mainFighter {
                        continue
                    }
                }
                // ここから
                let myFighterName = record.myFighter
                let opponentFighterName = record.opponentFighter
                let stageName = record.stage
                var sort = ""

                switch sortName {
                case "myFighter":
                    sort = myFighterName
                case "opponentFighter":
                    sort = opponentFighterName
                case "stage":
                    sort = stageName
                default:
                    sort = opponentFighterName
                }

                var newResult: [Any] = []
                var game = 1
                var win = 0
                var lose = 0 // ここで定義する必要なないが、わかりやすいかと
                var winRate: Float

                if record.result == "win" {
                    
                    win = 1
                }

                // fighterチェック
                var loopInt = 0 // resultRecordsをremoveするため
                for result in resultRecords {
                    // データの更新
                    if result[0] as! String == sort {

                        let existingGame = result[1] as! Int
                        var existingWin = result[2] as! Int

                        if record.result == "win" {

                            existingWin += 1
                        }

                        game = existingGame + 1
                        win = existingWin

                        resultRecords.remove(at: loopInt)
                        break
                    }

                    loopInt += 1
                }

                lose = game - win
                winRate = roundf(Float(win) / Float(game) * 1000) / 10
                newResult = [sort, game, win, lose ,winRate]
                // ここまでで、完結させる
                resultRecords.append(newResult)
            }

            self.insertOutputRecord(resultRecords: resultRecords, sortName: sortName)

        }
        .store(in: &cancellables)

        calculateTotalRecord()
    }


    private func insertOutputRecord(resultRecords: [[Any]], sortName: String) {
        for result in resultRecords {
            // map や　as! String ではうまくいかなかった
            let name = result[0] as! String
            let game = "\(result[1])"
            let win = "\(result[2])"
            let lose = "\(result[3])"
            let winRate = "\(result[4])%"

            // outputRecordの中身を更新
            var loopInt = 0

            //output先の分岐
            if sortName == "stage" {

                for output in self.outputStageRecord {

                    if output[0] == name {

                        break
                    }

                    loopInt += 1
                }

                let newOutput = [name, game, win, lose, winRate]

                self.outputStageRecord.insert(newOutput, at: loopInt)
                self.outputStageRecord.remove(at: loopInt + 1)
            } else {

                for output in self.outputRecord {

                    if output[0] == name {

                        break
                    }
                    loopInt += 1
                }

                let newOutput = [name, game, win, lose, winRate]
                self.outputRecord.insert(newOutput, at: loopInt)
                self.outputRecord.remove(at: loopInt + 1)
            }
        }
    }

    private func loadMainFighter() {

        userDefaults.register(defaults: ["MainFighter": "mario"])

        mainFighter = userDefaults.object(forKey: "MainFighter") as! String
    }

    func updateMainFighter(fighterName: String) {

        userDefaults.set(fighterName, forKey: "MainFighter")

        mainFighter = fighterName
    }

    private func calculateTotalRecord() {

        analysisRepository.$records.map { records in

            var game: Int = 0
            var win: Int = 0
            var lose: Int = 0
            var winRate: Float

            records.filter { record in

                record.myFighter == self.mainFighter
            }
            .map { record in

                game += 1

                if record.result == "win" {

                    win += 1
                } else {

                    lose += 1
                }
            }

            winRate = roundf(Float(win) / Float(game) * 1000) / 10

            let output: [String] = ["Total", "\(game)", "\(win)", "\(lose)", "\(winRate)%"]

            return output
        }
        .assign(to: \.totalRecord, on: self)
        .store(in: &cancellables)
    }
}


/*
 ["mario", "0", "0", "0", "0"],
 ["donkey_kong", "0", "0", "0", "0"],
 ["link", "0", "0","0", "0"],
 ["samus", "0", "0", "0", "0"],
 ["dark_samus", "0", "0", "0", "0"],
 ["yoshi", "0", "0", "0", "0"],
 ["kirby", "0", "0", "0", "0"],
 ["fox", "0", "0", "0", "0"],
 ["pikachu", "0", "0", "0", "0"],
 ["luigi", "0", "0", "0", "0"],
 ["ness", "0", "0", "0", "0"],
 ["captain_falcon", "0", "0", "0", "0"],
 ["purin", "0", "0", "0", "0"],
 ["peach", "0", "0", "0", "0"],
 ["daisy", "0", "0", "0", "0"],
 ["koopa", "0", "0", "0", "0"],
 ["ice_climber", "0", "0", "0", "0"],
 ["sheik", "0", "0", "0", "0"],
 ["zelda", "0", "0", "0", "0"],
 ["dr_mario","0", "0", "0", "0"],
 ["pichu", "0", "0", "0", "0"],
 ["falco", "0", "0", "0", "0"],
 ["marth", "0", "0", "0", "0"],
 ["lucina", "0", "0", "0", "0"],
 ["young_link", "0", "0", "0", "0"],
 ["ganondorf", "0", "0", "0", "0"],
 ["mewtwo", "0", "0", "0", "0"],
 ["roy", "0", "0", "0", "0"],
 ["chrom", "0", "0", "0", "0"],
 ["mr_game_and_watch", "0", "0", "0", "0"],
 ["meta_knight", "0", "0", "0", "0"],
 ["pit", "0", "0", "0", "0"],
 ["black_pit", "0", "0", "0", "0"],
 ["zero_suit_samus", "0", "0", "0", "0"],
 ["wario", "0", "0", "0", "0"],
 ["snake", "0", "0", "0", "0"],
 ["ike", "0", "0", "0", "0"],
 ["pokemon_trainer", "0", "0", "0", "0"],
 ["diddy_kong", "0", "0", "0", "0"],
 ["lucas", "0", "0", "0", "0"],
 ["sonic", "0", "0", "0", "0"],
 ["dedede", "0", "0", "0", "0"],
 ["pikmin_and_olimar", "0", "0", "0", "0"],
 ["lucario", "0", "0", "0", "0"],
 ["robot", "0", "0", "0", "0"],
 ["toon_link", "0", "0", "0", "0"],
 ["wolf", "0", "0", "0", "0"],
 ["murabito", "0", "0", "0", "0"],
 ["rockman", "0", "0", "0", "0"],
 ["wii_fit_trainer", "0", "0", "0", "0"],
 ["rosetta_and_chiko", "0", "0", "0", "0"],
 ["little_mac", "0", "0", "0", "0"],
 ["gekkouga", "0", "0", "0", "0"],
 ["mii_fighter", "0", "0", "0", "0"],
 ["palutena", "0", "0", "0", "0"],
 ["pac_man", "0", "0", "0", "0"],
 ["reflet", "0", "0", "0", "0"],
 ["shulk", "0", "0", "0", "0"],
 ["koopa_jr", "0", "0", "0", "0"],
 ["duck_hunt", "0", "0", "0", "0"],
 ["ryu", "0", "0", "0", "0"],
 ["ken", "0", "0", "0", "0"],
 ["cloud", "0", "0", "0", "0"],
 ["kamui", "0", "0", "0", "0"],
 ["bayonetta", "0", "0", "0", "0"],
 ["inkling", "0", "0", "0", "0"],
 ["ridley", "0", "0", "0", "0"],
 ["simon", "0", "0", "0", "0"],
 ["richter", "0", "0", "0", "0"],
 ["king_k_rool", "0", "0", "0", "0"],
 ["shizue", "0", "0", "0", "0"],
 ["gaogaen", "0", "0", "0", "0"],
 ["packun_flower", "0", "0", "0", "0"],
 ["joker", "0", "0", "0", "0"],
 ["dq_hero", "0", "0", "0", "0"],
 ["banjo_and_kazooie", "0", "0", "0", "0"],
 ["terry", "0", "0", "0", "0"],
 ["byleth", "0", "0", "0", "0"],
 ["minmin", "0", "0", "0", "0"]
 */
