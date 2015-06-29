def make_change(total, coins)
	change = []
	return change if total == 0 || coins.empty?
	new_change = make_change(total, coins.drop(1))
	if (total - coins[0]) >= 0
		total -= coins[0]
		change << coins[0]
	else
		coins.shift
	end
	change += make_change(total, coins)
	return change if new_change.empty?
	change.size <= new_change.size ? change : new_change
end