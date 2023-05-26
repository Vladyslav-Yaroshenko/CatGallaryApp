//
//  Cat.swift
//  CatGallaryApp
//
//  Created by Vlad on 24.05.2023.
//

import Foundation

/**
 The Cat struct represents a cat in the Cat Gallery app.

 It contains various properties that provide information about the cat, such as its breeds, categories, ID, URL, width, and height.

 The Cat struct is Codable, meaning it can be encoded to and decoded from JSON format using the Codable protocol.

 The struct also includes nested structs, Breed and Category, which represent the breed information and category information of the cat, respectively. The Breed struct contains properties like weight, ID, name, temperament, origin, and various other characteristics of the breed. The Category struct contains properties for the ID and name of the category.

 This struct is designed to hold the data for a cat fetched from an external API and provide a structured representation of the cat's information within the Cat Gallery app.
 */
 

// MARK: - Cat
struct Cat: Codable {
    let breeds: [Breed]
    let categories: [Category]?
    let id: String
    let url: String
    let width, height: Int
}

// MARK: - Breed
struct Breed: Codable {
    let weight: Weight
    let id, name: String
    let cfaURL: String?
    let vetstreetURL: String
    let vcahospitalsURL: String?
    let temperament, origin, countryCodes, countryCode: String
    let description, lifeSpan: String
    let indoor: Int
    let lap: Int?
    let altNames: String
    let adaptability, affectionLevel, childFriendly, dogFriendly: Int
    let energyLevel, grooming, healthIssues, intelligence: Int
    let sheddingLevel, socialNeeds, strangerFriendly, vocalisation: Int
    let experimental, hairless, natural, rare: Int
    let rex, suppressedTail, shortLegs: Int
    let wikipediaURL: String
    let hypoallergenic: Int
    let referenceImageID: String

    enum CodingKeys: String, CodingKey {
        case weight, id, name
        case cfaURL = "cfa_url"
        case vetstreetURL = "vetstreet_url"
        case vcahospitalsURL = "vcahospitals_url"
        case temperament, origin
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case description
        case lifeSpan = "life_span"
        case indoor, lap
        case altNames = "alt_names"
        case adaptability
        case affectionLevel = "affection_level"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case grooming
        case healthIssues = "health_issues"
        case intelligence
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case vocalisation, experimental, hairless, natural, rare, rex
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case wikipediaURL = "wikipedia_url"
        case hypoallergenic
        case referenceImageID = "reference_image_id"
    }
}

// MARK: - Weight
struct Weight: Codable {
    let imperial, metric: String
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
}
