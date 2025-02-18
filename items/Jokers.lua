local nice = {
    type = 'Joker',
    key = 'nice',
	atlas = "shdwn_shitty_jokers",
    pos = coordinate(1),
    config = {extra = {retrigger = 69}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retrigger } }
	end,
    rarity = 2, cost = 6,
    blueprint_compat = true, eternal_compat = true, perishable_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only and context.other_card.base.value == 'shdwn_shitty_69' then
            return {
                message = localize('k_shdwn_shitty_nice'),
                repetitions = card.ability.extra.retrigger,
                card = context.blueprint_card or card
            }
		end
    end
}

return {
	enabled = Showdown_Shitty.config["Jokers"],
	list = function ()
		local list = {
            nice,
		}
		return list
	end,
	atlases = {
		{key = "shdwn_shitty_jokers", path = "Jokers/Jokers.png", px = 71, py = 95},
	},
	exec = function ()
        --
	end,
}