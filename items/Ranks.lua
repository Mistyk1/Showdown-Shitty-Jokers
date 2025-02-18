local function inject_p_card_suit_compat(suit, rank)
	local card = {
		name = rank.key .. ' of ' .. suit.key,
		value = rank.key,
		suit = suit.key,
		pos = { x = rank.pos.x, y = rank.suit_map[suit.key] or suit.pos.y },
		lc_atlas = rank.suit_map[suit.key] and rank.lc_atlas or suit.lc_atlas,
		hc_atlas = rank.suit_map[suit.key] and rank.hc_atlas or suit.hc_atlas,
	}
	if not findInTable(card.suit, baseSuits) then
		if not Showdown.extraSuits[card.suit] then
			sendWarnMessage("Unknown suit for "..card.name, "Showdown: Shitty Jokers")
			card.lc_atlas = 'showdown_unknownSuit'
			card.hc_atlas = 'showdown_unknownSuit'
			card.pos = {x = 0, y = 0}
		else
			card.lc_atlas = Showdown.extraSuits[card.suit].lc_atlas
			card.hc_atlas = Showdown.extraSuits[card.suit].hc_atlas
		end
	end
	G.P_CARDS[suit.card_key .. '_' .. rank.card_key] = card
end

local nice = { -- 69 Card
	type = 'Rank',
	key = '69',
	card_key = 'N',
	shorthand = 'nice',
	pos = { x = 0 },
	nominal = 69,
    next = { 'showdown_Zero' },
	hidden = true,
	hc_atlas = 'shdwn_shitty_cardsHC',
	lc_atlas = 'shdwn_shitty_cards',
	inject = function(self)
		for _, suit in pairs(SMODS.Suits) do
			inject_p_card_suit_compat(suit, self)
		end
	end,
	in_pool = function () return false end
} -- id: 69

return {
	enabled = Showdown_Shitty.config["Ranks"],
	list = function()
		local list = {
			nice,
		}
		return list
	end,
	exec = function()
		SMODS.Atlas({key = "shdwn_shitty_cards", path = "Ranks/Cards.png", px = 71, py = 95})
		SMODS.Atlas({key = "shdwn_shitty_cardsHC", path = "Ranks/CardsHC.png", px = 71, py = 95})

		--[[if (SMODS.Mods["Bunco"] or {}).can_load then
			SMODS.Atlas({key = "shdwn_shitty_exoticCards", path = "CrossMod/Bunco/Ranks/Cards.png", px = 71, py = 95})
			SMODS.Atlas({key = "shdwn_shitty_exoticCardsHC", path = "CrossMod/Bunco/Ranks/CardsHC.png", px = 71, py = 95})

			Showdown.extraSuits['bunc_Fleurons'] = {lc_atlas = 'shdwn_shitty_exoticCards', hc_atlas = 'shdwn_shitty_exoticCardsHC'}
			Showdown.extraSuits['bunc_Halberds'] = {lc_atlas = 'shdwn_shitty_exoticCards', hc_atlas = 'shdwn_shitty_exoticCardsHC'}
		end
		if (SMODS.Mods["MusicalSuit"] or {}).can_load then
			SMODS.Atlas({key = "shdwn_shitty_musicalCards", path = "CrossMod/MusicalSuit/Ranks/Cards.png", px = 71, py = 95})
			SMODS.Atlas({key = "shdwn_shitty_musicalCardsHC", path = "CrossMod/MusicalSuit/Ranks/CardsHC.png", px = 71, py = 95})

			Showdown.extraSuits['Notes'] = {lc_atlas = 'shdwn_shitty_musicalCards', hc_atlas = 'shdwn_shitty_musicalCardsHC'}
		end
		if (SMODS.Mods["InkAndColor"] or {}).can_load then
			SMODS.Atlas({key = "shdwn_shitty_inkColorCards", path = "CrossMod/InkAndColor/Ranks/Cards.png", px = 71, py = 95})
			SMODS.Atlas({key = "shdwn_shitty_inkColorCardsHC", path = "CrossMod/InkAndColor/Ranks/CardsHC.png", px = 71, py = 95})

			Showdown.extraSuits['ink_Inks'] = {lc_atlas = 'shdwn_shitty_inkColorCards', hc_atlas = 'shdwn_shitty_inkColorCardsHC'}
			Showdown.extraSuits['ink_Colors'] = {lc_atlas = 'shdwn_shitty_inkColorCards', hc_atlas = 'shdwn_shitty_inkColorCardsHC'}
		end]]--
	end
}