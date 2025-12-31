# Responsive Design Implementation

## Overview

This document describes the responsive design implementation for Regeddit Web, ensuring optimal user experience across mobile devices, tablets, and desktop screens.

## Breakpoints

Following Tailwind CSS conventions:

- **Mobile**: < 640px (sm)
- **Tablet**: 640px - 1023px (sm - lg)
- **Desktop**: ≥ 1024px (lg+)
- **Large Desktop**: ≥ 1280px (xl+)

### Critical Breakpoints Tested

- 320px - Small mobile devices
- 375px - iPhone SE, modern small phones
- 414px - iPhone Plus, large phones
- 768px - iPad, tablets
- 1024px - Small laptops, large tablets

## Key Features

### 1. Navbar (Navigation Bar)

**Mobile (< 1024px)**:
- Logo visible with hamburger menu button
- Navigation links collapse into full-screen overlay menu
- Touch targets: minimum 44px × 44px
- Menu slides from top with smooth transition

**Desktop (≥ 1024px)**:
- Full horizontal navigation with all links visible
- Auth buttons displayed inline
- No hamburger menu needed

**Implementation**:
- Component: `app/components/navbar/navbar_component.html.haml`
- Controller: `app/javascript/controllers/mobile_menu_controller.js`
- Features:
  - Toggle mobile menu with hamburger icon
  - Backdrop closes menu on tap
  - Keyboard accessible

### 2. Sidebar (Group List)

**Mobile (< 1024px)**:
- Hidden by default (off-screen with -translate-x-full)
- Floating action button in bottom-left corner
- Slides in from left as overlay when toggled
- Semi-transparent backdrop dims content
- Close button at top of sidebar

**Desktop (≥ 1024px)**:
- Always visible, fixed on left side
- No overlay or backdrop needed
- Static positioning

**Implementation**:
- Component: `app/components/side_group_list/side_group_list_component.html.haml`
- Controller: `app/javascript/controllers/sidebar_controller.js`
- Features:
  - Smooth slide transitions (300ms)
  - Backdrop click to close
  - Touch-friendly toggle button

### 3. Left Content Sidebar

**Mobile (< 1024px)**:
- Completely hidden to maximize content space
- User can access via main hamburger menu if needed

**Desktop (≥ 1024px)**:
- Visible, showing user profile and navigation
- Fixed width (256px / w-64)

### 4. Right Content Sidebar

**Mobile & Tablet (< 1280px)**:
- Hidden to maximize reading space

**Large Desktop (≥ 1280px)**:
- Visible showing popular communities
- Fixed width (320px / w-80)

### 5. Main Content Area

**Mobile**:
- Full width (100%) with minimal padding (12px)
- Cards stack vertically
- Post headers wrap to multiple lines when needed
- Action buttons wrap on small screens

**Tablet**:
- Moderate padding (16px)
- Cards maintain structure
- Some horizontal layout maintained

**Desktop**:
- Constrained max-width (768px / max-w-3xl)
- Centered with auto margins
- Optimal reading width

**Implementation Details**:
- Images: `w-full h-auto` for fluid resizing
- Typography: 
  - Mobile: base 14px (text-sm for secondary, text-base for primary)
  - Desktop: base 16px (text-sm, text-base, text-lg)
- Spacing:
  - Mobile: reduced gaps (gap-4, space-y-4)
  - Desktop: comfortable gaps (gap-6, space-y-6)

### 6. Cards & Posts

**Responsive Features**:
- Headers: Stack on mobile, inline on tablet+
- Images: Maintain aspect ratio, full width
- Footers: Stack on small screens, horizontal on larger
- Buttons: Minimum 44px height, adequate padding

**Touch Targets**:
- All interactive elements: min-h-[44px]
- Icon buttons: min-w-[44px] min-h-[44px]
- Adequate spacing between touch targets

## Accessibility

### Touch Targets
- Minimum size: 44px × 44px (WCAG 2.1 Level AAA)
- Applied to all buttons, links, and interactive elements
- Adequate spacing to prevent mis-taps

### Typography
- Minimum font size: 14px on mobile
- Proper line height for readability
- Text doesn't overflow or get cut off

### Contrast
- Maintained AA contrast ratios across all breakpoints
- Dark theme: light text on dark backgrounds

### Keyboard Navigation
- All interactive elements are focusable
- Logical tab order maintained
- Focus visible for all states

### Screen Readers
- Proper ARIA labels on icon-only buttons
- Semantic HTML structure
- Alternative text for images

## Performance

### Mobile Optimization
- Lazy loading for images (`loading="lazy"`)
- Responsive images with `w-full h-auto`
- Minimal layout shift during load
- Touch gestures optimized with CSS transforms

### CSS Strategy
- Utility-first with Tailwind CSS
- Mobile-first responsive approach
- Minimal custom CSS required
- Efficient class reuse

## Testing Strategy

### Manual Testing Checklist
- [ ] Test at 320px width
- [ ] Test at 375px width (iPhone SE)
- [ ] Test at 414px width (iPhone Plus)
- [ ] Test at 768px width (iPad)
- [ ] Test at 1024px width (desktop)
- [ ] Verify no horizontal scroll at any width
- [ ] Test hamburger menu open/close
- [ ] Test sidebar toggle on mobile
- [ ] Verify touch targets are adequate
- [ ] Test keyboard navigation
- [ ] Verify text remains readable at all sizes
- [ ] Check image scaling and proportions

### Browser Testing
- Chrome/Edge (Blink engine)
- Firefox (Gecko engine)
- Safari (WebKit engine)
- Mobile Safari (iOS)
- Chrome Mobile (Android)

## Implementation Files

### Components
- `app/components/navbar/navbar_component.html.haml` - Responsive navbar
- `app/components/side_group_list/side_group_list_component.html.haml` - Sidebar with mobile overlay
- `app/components/home/header_component.html.haml` - User header with responsive text

### Controllers (Stimulus)
- `app/javascript/controllers/mobile_menu_controller.js` - Navbar menu toggle
- `app/javascript/controllers/sidebar_controller.js` - Sidebar overlay toggle

### Views
- `app/views/home/index.html.haml` - Main content with responsive layout

### Tests
- `spec/components/navbar/navbar_component_spec.rb`
- `spec/components/side_group_list/side_group_list_component_spec.rb`
- `spec/components/home/header_component_spec.rb`

## Common Patterns

### Mobile-First Classes
```haml
/ Hidden on mobile, visible on large screens
.hidden.lg:block

/ Different padding for mobile vs desktop
.p-3.md:p-4.lg:p-6

/ Responsive text sizes
.text-sm.md:text-base.lg:text-lg

/ Flex direction change
.flex.flex-col.sm:flex-row
```

### Touch Targets
```haml
/ Minimum size for touch
.min-h-[44px].min-w-[44px]

/ With flex centering
.min-h-[44px].flex.items-center.justify-center
```

### Overlay Pattern
```haml
/ Mobile sidebar with overlay
%div{data: {controller: "sidebar"}}
  / Toggle button
  %button{data: {action: "click->sidebar#toggle"}}
  
  / Backdrop
  .hidden.fixed.inset-0.bg-black/50{data: {sidebar_target: "backdrop", action: "click->sidebar#close"}}
  
  / Sidebar with slide animation
  %aside.-translate-x-full.lg:translate-x-0.transition-transform{data: {sidebar_target: "sidebar"}}
```

## Future Improvements

- Add PWA support for mobile app-like experience
- Implement swipe gestures for sidebar navigation
- Add pull-to-refresh functionality
- Optimize images with srcset for different screen densities
- Consider adding orientation change handling
- Implement virtual scrolling for long lists on mobile

## Resources

- [Tailwind CSS Responsive Design](https://tailwindcss.com/docs/responsive-design)
- [WCAG 2.1 Touch Target Guidelines](https://www.w3.org/WAI/WCAG21/Understanding/target-size.html)
- [Mobile Web Best Practices](https://developer.mozilla.org/en-US/docs/Web/Guide/Mobile)
