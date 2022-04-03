VolcanoCraving = Class{}

function VolcanoCraving:init(params)
    self.creature_species = params.creature_species
    self.creature_color = params.creature_color
end

function VolcanoCraving:is_satisfied_by(offering)
    local species_satisfied = (self.creature_species == nil) or (self.creature_species == offering.species)
    local color_satisfied = (self.creature_color == nil) or (self.creature_color == offering.color)
    return species_satisfied and color_satisfied
end