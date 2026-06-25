# Final Cleanup Script - Remove remaining gradients and ensure consistency

$files = @(
    'C:\Projects\DemoStrategy\webGEN\ExecutiveSummary.html',
    'C:\Projects\DemoStrategy\webGEN\narrative-orchestration-glossary.html',
    'C:\Projects\DemoStrategy\webGEN\Stage-4-5-Technical-Glossary.html',
    'C:\Projects\DemoStrategy\webGEN\User-Journey-Experience-Workflow.html',
    'C:\Projects\DemoStrategy\webGEN\Revenue-Operations-Infographic.html',
    'C:\Projects\DemoStrategy\webGEN\Revenue-Operations-Strategy.html'
)

foreach ($filePath in $files) {
    Write-Output "Final cleanup: $($filePath.Split('\')[-1])"
    
    $content = Get-Content $filePath -Raw
    
    # Remove hero background gradient - replace with simple darker background
    $content = $content -replace '(\.hero\s*\{[^}]*?)background:\s*linear-gradient\(135deg[^)]+\),\s*var\(--bg-darker\);', '$1background: var(--bg-darker);'
    
    # Remove any remaining multi-line background gradients
    $content = $content -replace 'background:\s*linear-gradient\([^\n]+\n[^\n]+\n[^\n]+var\(--bg-darker\);', 'background: var(--bg-darker);'
    
    # Clean up empty lines in CSS variables section
    $content = $content -replace '(\s*--[a-z-]+:\s*;?\s*\n){2,}', "`n"
    
    # Ensure consistent color values
    $content = $content -replace '#090e1b', '#090E1B'
    $content = $content -replace '#0f1629', '#0F1629'
    $content = $content -replace '#f97316', '#F97316'
    
    # Remove overflow: hidden from hero if present (not needed without pseudo-elements)
    $content = $content -replace '(\.hero\s*\{[^}]*?)overflow:\s*hidden;', '$1'
    
    # Remove position: relative from hero if present (not needed without pseudo-elements)  
    $content = $content -replace '(\.hero\s*\{[^}]*?)position:\s*relative;', '$1'
    
    # Clean up any remaining empty CSS rules
    $content = $content -replace '\s*\.\w+::\w+\s*\{\s*\}', ''
    
    # Ensure section-title uses simple border, not gradient
    $content = $content -replace '(\.section-title::before\s*\{[^}]*?)background:\s*linear-gradient[^;]+;', '$1background: var(--orange);'
    
    # Remove inline styles that might conflict
    $content = $content -replace 'style="margin-top:\s*16px;"', ''
    
    # Save cleaned file
    Set-Content -Path $filePath -Value $content -NoNewline
    
    Write-Output "  âœ" Cleaned: $($filePath.Split('\')[-1])"
}

Write-Output "`nFinal cleanup complete! All files now use clean design system."
