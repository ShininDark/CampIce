var targetPct = mineralHealth / mineralHealthMax;
displayedHealthPct = lerp(displayedHealthPct, targetPct, 0.1); // tune 0.1 for speed