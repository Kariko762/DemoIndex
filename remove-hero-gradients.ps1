# Remove Hero Background Gradients - Final Pass

$files = @(
    'C:\Projects\DemoStrategy\webGEN\ExecutiveSummary.html',
    'C:\Projects\DemoStrategy\webGEN\narrative-orchestration-glossary.html',
    'C:\Projects\DemoStrategy\webGEN\Stage-4-5-Technical-Glossary.html',
    'C:\Projects\DemoStrategy\webGEN\User-Journey-Experience-Workflow.html',
    'C:\Projects\DemoStrategy\webGEN\Revenue-Operations-Infographic.html',
    'C:\Projects\DemoStrategy\webGEN\Revenue-Operations-Strategy.html'
)

foreach ($filePath in $files) {
    Write-Output "Removing hero gradients: $($filePath.Split('\')[-1])"
    
    $content = Get-Content $filePath -Raw
    
    # Remove multi-line background gradient in hero - be specific about the pattern
    $content = $content -replace 'background:\s*\n\s*linear-gradient\(135deg[^\n]+\n[^\n]+var\(--bg-darker\);', 'background: var(--bg-darker);'
    
    # Alternative pattern for gradients
    $content = $content -replace '(\.hero\s*\{[^}]*?)background:[^;]*?linear-gradient[^;]+;', '$1background: var(--bg-darker);'
    
    # Clean up extra empty lines in hero block
    $content = $content -replace '(\.hero\s*\{[^}]*?)\n\s*\n\s*\n', '$1'
    
    # Save file
    Set-Content -Path $filePath -Value $content -NoNewline
    
    Write-Output "  âœ" Done: $($filePath.Split('\')[-1])"
}

Write-Output "`nHero gradients removed!"
