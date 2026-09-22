/// Data model for rank tiers along the cosmic career path.
class RankTierModel {
  final int rank;
  final String name;
  final String emoji;
  final int requiredPoints;
  final String description;
  final List<String> benefits;
  final List<String> howToReach;
  final bool isUnlocked;
  final bool isCurrent;

  const RankTierModel({
    required this.rank,
    required this.name,
    required this.emoji,
    required this.requiredPoints,
    required this.description,
    required this.benefits,
    required this.howToReach,
    this.isUnlocked = false,
    this.isCurrent = false,
  });

  static const List<RankTierModel> defaultTiers = [
    RankTierModel(
      rank: 1,
      name: 'Garden',
      emoji: '🌱',
      requiredPoints: 100,
      description: 'The foundation of eco-driving. Planting the seeds for greener mobility.',
      benefits: [
        'Standard eco-point tracking',
        'Access to community milestones',
        'Basic garden badge',
      ],
      howToReach: [
        'Log your first 5 trips',
        'Avoid harsh acceleration',
      ],
      isUnlocked: true,
    ),
    RankTierModel(
      rank: 2,
      name: 'Phytoplankton',
      emoji: '🦠',
      requiredPoints: 250,
      description: 'Producing clean air and steady habits with every kilometre traveled.',
      benefits: [
        'Weekly activity summary',
        'Basic reward multiplier (1.1x)',
        'Phytoplankton tier badge',
      ],
      howToReach: [
        'Maintain speed limits for 10 trips',
        'Reduce idling time by 15%',
      ],
      isUnlocked: true,
    ),
    RankTierModel(
      rank: 3,
      name: 'Small Fish',
      emoji: '🐟',
      requiredPoints: 500,
      description: 'Navigating efficiently through city traffic with smooth braking.',
      benefits: [
        'Bonus points on eco-routes',
        'Small Fish badge showcase',
        '1.2x reward multiplier',
      ],
      howToReach: [
        'Complete 20 eco-certified trips',
        'Log at least 3 routes per week',
      ],
      isUnlocked: true,
    ),
    RankTierModel(
      rank: 4,
      name: 'Dolphin',
      emoji: '🐬',
      requiredPoints: 850,
      description:
          'Your efforts are starting to stand out. Keep choosing greener routes to swim toward bigger rewards.',
      benefits: [
        'Bonus reward multiplier (1.5x)',
        'Weekly leaderboard eligibility',
        'Special Dolphin badge',
        'Higher reward limits',
        'Exclusive achievements',
      ],
      howToReach: [
        'Complete more tasks',
        'Improve your performance score',
        'Reduce penalties',
        'Stay active every week',
        'Maintain consistency',
      ],
      isUnlocked: true,
      isCurrent: true,
    ),
    RankTierModel(
      rank: 5,
      name: 'Shark',
      emoji: '🦈',
      requiredPoints: 1200,
      description: 'Dominating efficiency charts with fierce precision and mastery.',
      benefits: [
        'Shark tier halo aura',
        '2.0x points multiplier',
        'Priority matchmaking in games',
        'Exclusive weekly jackpot entry',
      ],
      howToReach: [
        'Earn 100 Eco Points in Dolphin tier',
        'Zero penalties for 14 consecutive days',
      ],
    ),
    RankTierModel(
      rank: 6,
      name: 'Bear',
      emoji: '🐻',
      requiredPoints: 1800,
      description: 'A powerhouse of steady, sustainable driving force on every route.',
      benefits: [
        'Elite driver badge',
        '2.5x points multiplier',
        'Custom vehicle skins unlocked',
      ],
      howToReach: [
        'Maintain top 10% monthly driving score',
        'Log over 500 green kilometres',
      ],
    ),
    RankTierModel(
      rank: 7,
      name: 'Lion',
      emoji: '🦁',
      requiredPoints: 2500,
      description: 'The undisputed monarch of green mobility, leading the galaxy leaderboard.',
      benefits: [
        'Legendary Lion badge with glowing crown',
        '3.0x max reward multiplier',
        'VIP hall of fame listing',
        'Exclusive royal cosmetics',
      ],
      howToReach: [
        'Reach rank 1 in seasonal tournament',
        'Maintain 95+ score for 30 consecutive days',
      ],
    ),
  ];
}
