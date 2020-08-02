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
    @Published var resultRecords: [[Any]] = [
        ["mario", 0, 0, 0, 0],
        ["donkey_kong", 0, 0, 0, 0],
        ["link", 0, 0,0, 0],
        ["samus", 0, 0, 0, 0],
        ["dark_samus", 0, 0, 0, 0],
        ["yoshi", 0, 0, 0, 0],
        ["kirby", 0, 0, 0, 0],
        ["fox", 0, 0, 0, 0],
        ["pikachu", 0, 0, 0, 0],
        ["luigi", 0, 0, 0, 0],
        ["ness", 0, 0, 0, 0],
        ["captain_falcon", 0, 0, 0, 0],
        ["purin", 0, 0, 0, 0],
        ["peach", 0, 0, 0, 0],
        ["daisy", 0, 0, 0, 0],
        ["koopa", 0, 0, 0, 0],
        ["ice_climber", 0, 0, 0, 0],
        ["sheik", 0, 0, 0, 0],
        ["zelda", 0, 0, 0, 0],
        ["dr_mario",0, 0, 0, 0],
        ["pichu", 0, 0, 0, 0],
        ["falco", 0, 0, 0, 0],
        ["marth", 0, 0, 0, 0],
        ["lucina", 0, 0, 0, 0],
        ["young_link", 0, 0, 0, 0],
        ["ganondorf", 0, 0, 0, 0],
        ["mewtwo", 0, 0, 0, 0],
        ["roy", 0, 0, 0, 0],
        ["chrom", 0, 0, 0, 0],
        ["mr_game_and_watch", 0, 0, 0, 0],
        ["meta_knight", 0, 0, 0, 0],
        ["pit", 0, 0, 0, 0],
        ["black_pit", 0, 0, 0, 0],
        ["zero_suit_samus", 0, 0, 0, 0],
        ["wario", 0, 0, 0, 0],
        ["snake", 0, 0, 0, 0],
        ["ike", 0, 0, 0, 0],
        ["pokemon_trainer", 0, 0, 0, 0],
        ["diddy_kong", 0, 0, 0, 0],
        ["lucas", 0, 0, 0, 0],
        ["sonic", 0, 0, 0, 0],
        ["dedede", 0, 0, 0, 0],
        ["pikmin_and_olimar", 0, 0, 0, 0],
        ["lucario", 0, 0, 0, 0],
        ["robot", 0, 0, 0, 0],
        ["toon_link", 0, 0, 0, 0],
        ["wolf", 0, 0, 0, 0],
        ["murabito", 0, 0, 0, 0],
        ["rockman", 0, 0, 0, 0],
        ["wii_fit_trainer", 0, 0, 0, 0],
        ["rosetta_and_chiko", 0, 0, 0, 0],
        ["little_mac", 0, 0, 0, 0],
        ["gekkouga", 0, 0, 0, 0],
        ["mii_fighter", 0, 0, 0, 0],
        ["palutena", 0, 0, 0, 0],
        ["pac_man", 0, 0, 0, 0],
        ["reflet", 0, 0, 0, 0],
        ["shulk", 0, 0, 0, 0],
        ["koopa_jr", 0, 0, 0, 0],
        ["duck_hunt", 0, 0, 0, 0],
        ["ryu", 0, 0, 0, 0],
        ["ken", 0, 0, 0, 0],
        ["cloud", 0, 0, 0, 0],
        ["kamui", 0, 0, 0, 0],
        ["bayonetta", 0, 0, 0, 0],
        ["inkling", 0, 0, 0, 0],
        ["ridley", 0, 0, 0, 0],
        ["simon", 0, 0, 0, 0],
        ["richter", 0, 0, 0, 0],
        ["king_k_rool", 0, 0, 0, 0],
        ["shizue", 0, 0, 0, 0],
        ["gaogaen", 0, 0, 0, 0],
        ["packun_flower", 0, 0, 0, 0],
        ["joker", 0, 0, 0, 0],
        ["dq_hero", 0, 0, 0, 0],
        ["banjo_and_kazooie", 0, 0, 0, 0],
        ["terry", 0, 0, 0, 0],
        ["byleth", 0, 0, 0, 0],
        ["minmin", 0, 0, 0, 0],
    ]
    var opponentFighterName = ""
    var loopInt = 0

    private var cancellables = Set<AnyCancellable>()

    init() {

        analysisRepository.$mainAnalysisRecords.sink { records in

            for record in records {


                self.loopInt = 0
                for resultRecord in self.resultRecords {

                    if record.opponentFighter == resultRecord[0] as! String {

                        var game = resultRecord[1] as! Int
                        var win = resultRecord[2] as! Int
                        var lose = resultRecord[3] as! Int

                        game += 1
                        if record.result == "win" {
                            win += 1
                        } else {
                            lose += 1
                        }
                        let winRate = Float(win) / Float(game) * 100

                        print(resultRecord)

                        break
                    }
//                    if record.opponentFighter == resultRecord.opponentFighter {
//
//                        self.opponentFighterName = record.opponentFighter
//
//                        break
//                    }
//                    self.loopInt += 1
                }

//                var fighterResult = self.resultRecords[self.loopInt]
//
//                fighterResult.game += 1
//                if record.result == "win" {
//                    fighterResult.win += 1
//                } else {
//                    fighterResult.lose += 1
//                }
//                fighterResult.winRate = Float(fighterResult.win) / Float(fighterResult.game) * 100

            }

        }
        .store(in: &cancellables)
        
    }

}
