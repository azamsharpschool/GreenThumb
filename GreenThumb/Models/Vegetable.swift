//
//  Vegetable.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/6/25.
//

import Foundation
import SwiftData

@Model
class Vegetable: Decodable {
    var vegetableId: Int
    var vegetableCode: String
    var name: String
    var body: String
    var thumbnailImage: URL
    var seedDepth: String
    var germinationSoilTemp: String
    var daysToGermination: Int
    var sowIndoors: String
    var sowOutdoors: String
    var phRange: String
    var growingSoilTemp: String
    var spacingBeds: String
    var watering: String
    var light: String
    var goodCompanions: String
    var badCompanions: String
    var sowingDescription: String?
    var growingDescription: String
    var harvestDescription: String
    var active: Bool?
    var season: String
    var daysToHarvestSeeds: Int
    var daysToHarvestSeedlings: Int
    var healthBenefits: String
    
    @Relationship(deleteRule: .nullify)
    var pests: [Pest]?
    
    required init(from decoder: Decoder) throws {
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.vegetableId = try container.decode(Int.self, forKey: .vegetableId)
            self.vegetableCode = try container.decode(String.self, forKey: .vegetableCode)
            self.name = try container.decode(String.self, forKey: .name)
            self.body = try container.decode(String.self, forKey: .body)
            self.thumbnailImage = try container.decode(URL.self, forKey: .thumbnailImage)
            self.seedDepth = try container.decode(String.self, forKey: .seedDepth)
            self.germinationSoilTemp = try container.decode(String.self, forKey: .germinationSoilTemp)
            self.daysToGermination = try container.decode(Int.self, forKey: .daysToGermination)
            self.sowIndoors = try container.decode(String.self, forKey: .sowIndoors)
            self.sowOutdoors = try container.decode(String.self, forKey: .sowOutdoors)
            self.phRange = try container.decode(String.self, forKey: .phRange)
            self.growingSoilTemp = try container.decode(String.self, forKey: .growingSoilTemp)
            self.spacingBeds = try container.decode(String.self, forKey: .spacingBeds)
            self.watering = try container.decode(String.self, forKey: .watering)
            self.light = try container.decode(String.self, forKey: .light)
            self.goodCompanions = try container.decode(String.self, forKey: .goodCompanions)
            self.badCompanions = try container.decode(String.self, forKey: .badCompanions)
            self.sowingDescription = try container.decodeIfPresent(String.self, forKey: .sowingDescription)
            self.growingDescription = try container.decode(String.self, forKey: .growingDescription)
            self.harvestDescription = try container.decode(String.self, forKey: .harvestDescription)
            self.active = try container.decodeIfPresent(Bool.self, forKey: .active)
            self.season = try container.decode(String.self, forKey: .season)
            self.daysToHarvestSeeds = try container.decode(Int.self, forKey: .daysToHarvestSeeds)
            self.daysToHarvestSeedlings = try container.decode(Int.self, forKey: .daysToHarvestSeedlings)
            self.healthBenefits = try container.decode(String.self, forKey: .healthBenefits)
            self.pests = try container.decode([Pest].self, forKey: .pests)
           
        }
    
    enum CodingKeys: String, CodingKey {
        case vegetableId = "VegetableId"
        case vegetableCode = "VegetableCode"
        case name = "Name"
        case body = "Description"
        case thumbnailImage = "ThumbnailImage"
        case seedDepth = "SeedDepth"
        case germinationSoilTemp = "GerminationSoilTemp"
        case daysToGermination = "DaysToGermination"
        case sowIndoors = "SowIndoors"
        case sowOutdoors = "SowOutdoors"
        case phRange = "PhRange"
        case growingSoilTemp = "GrowingSoilTemp"
        case spacingBeds = "SpacingBeds"
        case watering = "Watering"
        case light = "Light"
        case goodCompanions = "GoodCompanions"
        case badCompanions = "BadCompanions"
        case sowingDescription = "SowingDescription"
        case growingDescription = "GrowingDescription"
        case harvestDescription = "HarvestDescription"
        case active = "Active"
        case season = "Season"
        case daysToHarvestSeeds = "DaysToHarvestSeeds"
        case daysToHarvestSeedlings = "DaysToHarvestSeedlings"
        case healthBenefits = "HealthBenefits"
        case pests = "Pests"
    }
}
