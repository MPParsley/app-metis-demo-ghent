# Stad Gent Stijlgids (v6) - Referentie

*Bewaard op: 2025-07-08*  
*Bron: https://stijlgids.stad.gent/v6/*

## Overzicht

De Stad Gent stijlgids is een technologie-onafhankelijke designsysteem dat flexibiliteit biedt voor verschillende platforms zoals Drupal, Vue, en Nuxt. Het focus op modulaire, herbruikbare componenten.

## Design Principes

- **Technologie-onafhankelijk**: Werkt met verschillende frameworks en platforms
- **Modulair ontwerp**: Herbruikbare componenten
- **Flexibiliteit**: Aanpasbaar voor verschillende implementaties
- **Consistentie**: Uniforme user experience across alle stad Gent applicaties

## Typografie

- Gebruikt SASS voor typografie management
- Specifieke font details beschikbaar in de component documentatie
- Hiërarchische benadering voor koppen en tekst

## Kleuren

- **Standaard thema**: "Blue"
- Uitgebreide kleurenpalette beschikbaar in de "Colors" component sectie
- Consistent gebruik van stad Gent merkkleur

## Layout Systeem

- **Grid systeem**: Breakpoint-sass en Susy voor responsive layouts
- **Layout templates**:
  - Detail layout
  - Filter layout
  - Overview layout
  - Sidebar Right layout
- Responsive design met meerdere breakpoints

## Component Library

Georganiseerd in een hiërarchische structuur:

### Base Components
- Fundamentele styling elementen

### Atoms
- Buttons
- Icons
- Links
- Basis UI elementen

### Molecules
- Forms
- Menus
- Modals
- Samengestelde componenten

### Organisms
- Headers
- Footers
- Galleries
- Complexe interface secties

### Layouts
- Template structuren voor pagina's

## Accessibility

- Automatische JavaScript enhancement detection
- Verwijdert 'no-js' class en voegt 'has-js' toe
- Skiplinks voor keyboard navigatie
- WCAG compliance focus

## Responsive Design

- SASS-based responsive framework
- Multiple device support
- Flexible breakpoint systeem
- Mobile-first approach

## Brand Guidelines

- **Beheerd door**: City of Ghent
- **Contact**: ttweb@district09.gent
- **Officiële bron**: https://stijlgids.stad.gent/v6/

## Implementatie

### Installatie
```bash
npm install gent_styleguide
```

### SASS Import
```scss
$styleguide-dir: '../../../node_modules/gent_styleguide/build/styleguide' !default;
@import "sass/main_cli";
```

### Gebruik in projecten
- Importeer specifieke componenten
- Gebruik de meegeleverde SASS variabelen
- Volg de component documentatie voor correcte implementatie

## CSS/HTML Patterns

- **Modulaire SASS architectuur**
- **Versie-gecontroleerde releases**
- **Technologie-agnostische component design**
- **BEM-achtige naamgeving** voor CSS classes

## Belangrijke aanbevelingen

1. **Raadpleeg altijd de specifieke component documentatie** voor gedetailleerde implementatie guidelines
2. **Gebruik de officiële npm package** voor consistente updates
3. **Volg de accessibility guidelines** voor alle implementaties
4. **Test op verschillende devices** met het responsive systeem

## Nuttige links

- Hoofdpagina: https://stijlgids.stad.gent/v6/
- Component library: Beschikbaar via de hoofdpagina
- Documentatie: Geïntegreerd in de stijlgids website

## Notities voor ontwikkelaars

- De stijlgids is bedoeld om consistent te zijn across alle stad Gent digitale producten
- Gebruik altijd de laatste versie van de stijlgids
- Bij vragen of problemen, contacteer het team via ttweb@district09.gent
- De stijlgids ondersteunt zowel traditionele als moderne development workflows

---

*Deze referentie is bewaard voor toekomstig gebruik in andere projecten. Update indien nodig bij nieuwe releases van de stijlgids.*