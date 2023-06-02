export default {
  app: "FleetYards.net",
  meta: {
    description:
      "FleetYards.net, Deine Datenbank für alle Information rund um die Schiffe & Stationen von “Star Citizen“.",
    keywords:
      "Star, Citizen, Spaceships, Raumschiffe, Weltraum, Ships, Fighter, Database, Squadron, 42, Star, Citizen, English, Chris, Roberts, Online, Game, Space, Simulation",
  },
  station: {
    type: "Typ",
    location: "Himmelskörper",
    classification: "Klassifizierung",
    habitable: "Bewohnbar?",
    refinery: "Raffinerie-Station",
    cargoHub: "Frachtzentrum",
  },
  model: {
    focus: "Fokus",
    classification: "Klassifizierung",
    size: "Größe",
    beam: "Breite",
    cargo: "Fracht",
    netCargo: "Fracht mit Rover/Snub",
    crew: "Besatzung",
    speed: "Geschwindigkeit",
    minCrew: "min. Besatzung",
    maxCrew: "max. Besatzung",
    scmSpeed: "SCM-Geschwindigkeit",
    afterburnerSpeed: "Nachbrenner Geschwindigkeit",
    groundSpeed: "Geschwindigkeit am Boden",
    afterburnerGroundSpeed: "mit Nachbrenner",
    pitchMax: "Max. Nick (Pitch)",
    yawMax: "Max. Gier (Yaw)",
    rollMax: "Roll-Max",
    price: "Preis",
    pledgePrice: "Pledge-Preis",
    xaxisAcceleration: "X-Achse",
    yaxisAcceleration: "Y-Achse",
    zaxisAcceleration: "Z-Achse",
    quantumFuelTankSize: "Quantum Treibstoff",
    hydrogenFuelTankSize: "Treibstoff",
    height: "Höhe",
    length: "Länge",
    mass: "Masse",
    manufacturer: "Hersteller",
    hardpoints: "Aufhängungen",
    weapons: "Waffen",
    equipment: "Equipment",
    variants: "Varianten",
    maxUpgrades: "Upgrades",
    productionStatus: "Produktionsstatus",
    propulsion: "Antrieb",
    ordnance: "Gegenmaßnahmen",
    modular: "Modular",
    soldAt: "Verkauft bei?",
    rentalAt: "Vermietung bei?",
    lastUpdatedAt: "Zuletzt aktualisiert am?",
  },
  component: {
    manufacturer: "Hersteller",
    size: "Größe",
  },
  celestialObject: {
    type: "Typ",
    subType: "Unterart",
    habitable: "Bewohnbar?",
    fairchanceact: "Fair Chance Act?",
    population: "Bevölkerung",
    economy: "Wirtschaft",
    danger: "Gefahr",
  },
  starsystem: {
    type: "Typ",
    size: "Größe",
    population: "Bevölkerung",
    economy: "Wirtschaft",
    danger: "Gefahr",
  },
  shop: {
    type: "Typ",
    celestialObject: "Himmelskörper",
    station: "Station",
    location: "%{name} in %{location}",
    refineryTerminal: "Raffinerie-Terminal",
  },
  commodityItem: {
    grade: "Stufe",
    type: "Typ",
    itemType: "Item-Typ",
    itemClass: "Item-Klasse",
    weaponClass: "Waffenklasse",
    size: "Größe",
    range: "Reichweite",
    damageReduction: "Schadensreduktion",
    rateOfFire: "Feuerrate",
    extras: "Zusätzliche Informationen",
    location: "Position",
    slot: "Slot",
    storage: "Lager",
    shop: "Shop",
    unconfirmed: "Item ist unbestätigt",
    manufacturer: "Hersteller",
  },
  shopCommodity: {
    listedAt: "Gelistet bei",
    soldAt: "Verkauft bei",
    boughtAt: "Gekauft von",
  },
  resources: {
    models: "Schiffe",
    images: "Bilder",
  },
  pagination: {
    previous: "Vorherige Seite",
    next: "Nächste Seite",
    gap: "&hellip;",
  },
  datetime: {
    formats: {
      default: "L MMMM y 'um' HH:mm z",
      iso: "yyyy-MM-dd'T'HH:mm:ss.SSSxxx",
    },
  },
  number: {
    format: {
      precision: 2,
      strip_insignificant_zeros: true,
      delimiter: ".",
      separator: ".",
    },
    percent: "%{count} %",
    distance: "%{count} m",
    weight: "%{count} t",
    speed: "%{count} m/s",
    rateOfFire: "%{count} Schüsse/min",
    rotation: "%{count} Grad/s",
    cargo: "%{count} SCU",
    fuel: "%{count}",
    ships: {
      one: "%{count} Schiff",
      other: "%{count} Schiffe",
    },
    people: {
      one: "%{count} Person",
      other: "%{count} Personen",
    },
  },
};