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
    @Published var analysisCellViewModels = [AnalysisCellViewModel]()
//    var resultRecords: [MainAnalysis] = [
//        MainAnalysis(opponentFighter: "mario", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "donkey_kong", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "link", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "samus", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "dark_samus", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "yoshi", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "kirby", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "fox", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "pikachu", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "luigi", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "ness", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "captain_falcon", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "purin", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "peach", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "daisy", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "koopa", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "ice_climber", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "sheik", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "zelda", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "dr_mario", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "pichu", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "falco", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "marth", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "lucina", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "young_link", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "ganondorf", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "mewtwo", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "roy", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "chrom", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "mr_game_and_watch", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "meta_knight", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "pit", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "black_pit", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "zero_suit_samus", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "wario", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "snake", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "ike", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "pokemon_trainer", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "diddy_kong", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "lucas", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "sonic", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "dedede", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "pikmin_and_olimar", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "lucario", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "robot", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "toon_link", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "wolf", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "murabito", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "rockman", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "wii_fit_trainer", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "rosetta_and_chiko", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "little_mac", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "gekkouga", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "mii_fighter", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "palutena", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "pac_man", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "reflet", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "shulk", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "koopa_jr", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "duck_hunt", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "ryu", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "ken", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "cloud", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "kamui", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "bayonetta", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "inkling", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "ridley", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "simon", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "richter", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "king_k_rool", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "shizue", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "gaogaen", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "packun_flower", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "joker", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "dq_hero", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "banjo_and_kazooie", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "terry", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "byleth", game: 0, win: 0, lose: 0, winRate: 0),
//        MainAnalysis(opponentFighter: "minmin", game: 0, win: 0, lose: 0, winRate: 0),
//    ]
    var opponentFighterName = ""
    var loopInt = 0

    private var cancellables = Set<AnyCancellable>()

    init() {

        analysisRepository.$mainAnalysisRecords.sink { records in

            for record in records {



                /*
                 self.loopInt = 0
                for resultRecord in self.resultRecords {

                    if record.opponentFighter == resultRecord.opponentFighter {

                        self.opponentFighterName = record.opponentFighter

                        break
                    }
                    self.loopInt += 1
                }

                var fighterResult = self.resultRecords[self.loopInt]

                fighterResult.game += 1
                if record.result == "win" {
                    fighterResult.win += 1
                } else {
                    fighterResult.lose += 1
                }
                fighterResult.winRate = Float(fighterResult.win) / Float(fighterResult.game) * 100
                 */

            }

        }
        .store(in: &cancellables)

    }

}
