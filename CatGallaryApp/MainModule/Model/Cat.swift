//
//  Cat.swift
//  CatGallaryApp
//
//  Created by Vlad on 24.05.2023.
//

import Foundation

/**
 The Cat struct represents a cat and contains information about the cat's breed, categories, ID, image URL, width, and height. It is used to deserialize JSON data related to cats.

 The struct includes the following properties:

 - breeds: An array of Breed objects representing the cat's breed.
 However, it's worth noting that in most cases, the breeds property is not populated and remains empty. This is because the majority of cat instances do not have associated breed information available.
 - categories: An optional array of Category objects representing the categories associated with the cat.
 - id: A string representing the unique identifier of the cat.
 - url: A string representing the URL of the cat's image.
 - width: An integer representing the width of the cat's image.
 - height: An integer representing the height of the cat's image.
 
 It's important to highlight that due to the nature of the data source, the Cat struct mainly focuses on the image URL aspect of the cat's information. While the breeds and categories properties exist, they are often omitted or not provided in the data, resulting in empty or null values.

 The Cat struct is part of a larger data model and is used to retrieve and store information about cats, with an emphasis on the image URL aspect rather than detailed breed or category information.
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
