# HTML Refactoring Script - Clean Design System
# Removes gradients, backdrop-filters, and pill-shaped borders

$files = @(
    'C:\Projects\DemoStrategy\webGEN\ExecutiveSummary.html',
    'C:\Projects\DemoStrategy\webGEN\narrative-orchestration-glossary.html',
    'C:\Projects\DemoStrategy\webGEN\Stage-4-5-Technical-Glossary.html',
    'C:\Projects\DemoStrategy\webGEN\User-Journey-Experience-Workflow.html',
    'C:\Projects\DemoStrategy\webGEN\Revenue-Operations-Infographic.html',
    'C:\Projects\DemoStrategy\webGEN\Revenue-Operations-Strategy.html'
)

foreach ($filePath in $files) {
    Write-Output "Refactoring: $($filePath.Split('\')[-1])"
    
    $content = Get-Content $filePath -Raw
    
    # Remove radial-gradient backgrounds (multiple patterns)
    $content = $content -replace 'background:\s*radial-gradient\([^;]+\);', 'background: var(--bg-dark);'
    $content = $content -replace 'background:\s*radial-gradient\([^;]+\),\s*radial-gradient\([^;]+\),\s*linear-gradient\([^;]+\);', 'background: var(--bg-dark);'
    $content = $content -replace 'background:\s*linear-gradient\(135deg[^)]+\),\s*var\(--bg-darker\);', 'background: var(--bg-darker);'
    
    # Remove body::before pseudo-element with grid pattern
    $content = $content -replace 'body::before\s*\{[^}]+\}', ''
    
    # Remove backdrop-filter
    $content = $content -replace 'backdrop-filter:\s*blur\([^)]+\);', ''
    
    # Replace border-radius: 999px with 4px (pill shape to simple)
    $content = $content -replace 'border-radius:\s*999px;', 'border-radius: 4px;'
    
    # Replace large border-radius values
    $content = $content -replace 'border-radius:\s*28px;', 'border-radius: 8px;'
    $content = $content -replace 'border-radius:\s*24px;', 'border-radius: 6px;'
    $content = $content -replace 'border-radius:\s*22px;', 'border-radius: 6px;'
    $content = $content -replace 'border-radius:\s*20px;', 'border-radius: 6px;'
    $content = $content -replace 'border-radius:\s*18px;', 'border-radius: 6px;'
    $content = $content -replace 'border-radius:\s*14px;', 'border-radius: 4px;'
    
    # Replace var(--radius-lg) and var(--radius-md)
    $content = $content -replace 'border-radius:\s*var\(--radius-lg\);', 'border-radius: 8px;'
    $content = $content -replace 'border-radius:\s*var\(--radius-md\);', 'border-radius: 6px;'
    
    # Remove box-shadow with large blur
    $content = $content -replace 'box-shadow:\s*var\(--panel-shadow\);', ''
    $content = $content -replace 'box-shadow:\s*0\s+2[0-9]px\s+[0-9]+px[^;]+;', ''
    
    # Remove ::after pseudo-elements with radial gradients
    $content = $content -replace '\.hero::after\s*\{[^}]+\}', ''
    
    # Replace complex panel backgrounds
    $content = $content -replace 'background:\s*var\(--bg-panel\);', 'background: var(--bg-darker);'
    
    # Replace font-family: Georgia with sans-serif  
    $content = $content -replace "font-family:\s*Georgia,\s*'Times New Roman',\s*serif;", "font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', sans-serif;"
    
    # Replace eyebrow ::before decorative line
    $content = $content -replace '\.eyebrow::before\s*\{[^}]+\}', ''
    
    # Replace section-title ::before gradient bar with solid
    $content = $content -replace 'background:\s*linear-gradient\(180deg,\s*var\(--orange\),[^)]+\);', 'background: var(--orange);'
    $content = $content -replace 'border-radius:\s*999px;\s*background:\s*linear-gradient[^;]+;', 'background: var(--orange);'
    
    # Update CSS variables section - remove unused ones
    $content = $content -replace '--bg-panel:[^;]+;', '--bg-panel: var(--bg-darker);'
    $content = $content -replace '--text-muted:[^;]+;', '--text-muted: var(--text-grey);'
    $content = $content -replace '--panel-shadow:[^;]+;', ''
    $content = $content -replace '--panel-border:[^;]+;', ''
    $content = $content -replace '--radius-lg:[^;]+;', ''
    $content = $content -replace '--radius-md:[^;]+;', ''
    
    # Remove navigation wrapper and replace with direct nav
    $content = $content -replace '<div class="global-nav-wrap">\s*<nav class="global-nav"', '<nav class="global-nav"'
    $content = $content -replace '</nav>\s*</div>\s*<script>', '</nav><script>'
    
    # Update global-nav CSS
    $content = $content -replace '\.global-nav-wrap\s*\{[^}]+\}', ''
    $content = $content -replace '(\.global-nav\s*\{[^}]*?)border:\s*1px[^;]+;', '$1'
    $content = $content -replace '(\.global-nav\s*\{[^}]*?)box-shadow:[^;]+;', '$1'
    
    # Fix nav to use clean design
    $content = $content -replace 'border-radius:\s*999px;\s*background:\s*rgba\(9,\s*14,\s*27,\s*[0-9.]+\);', 'background: var(--bg-darker);'
    
    # Save refactored file
    Set-Content -Path $filePath -Value $content -NoNewline
    
    Write-Output "  âœ" Completed: $($filePath.Split('\')[-1])"
}

Write-Output "`nRefactoring complete! All 6 files updated with clean design system."
