# Navigation Update Script - Clean Design System
# Updates navigation to simple bar with border-bottom

$files = @(
    'C:\Projects\DemoStrategy\webGEN\ExecutiveSummary.html',
    'C:\Projects\DemoStrategy\webGEN\narrative-orchestration-glossary.html',
    'C:\Projects\DemoStrategy\webGEN\Stage-4-5-Technical-Glossary.html',
    'C:\Projects\DemoStrategy\webGEN\User-Journey-Experience-Workflow.html',
    'C:\Projects\DemoStrategy\webGEN\Revenue-Operations-Infographic.html',
    'C:\Projects\DemoStrategy\webGEN\Revenue-Operations-Strategy.html'
)

$cleanNavCSS = @'
        /* Navigation */
        .global-nav {
            background: var(--bg-darker);
            padding: 20px 24px;
            border-bottom: 3px solid var(--orange);
            margin-bottom: 32px;
        }

        .nav-container {
            max-width: var(--content-width);
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
            flex-wrap: wrap;
        }

        .global-brand {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .global-brand-mark {
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: var(--green);
        }

        .global-brand-title {
            font-size: 1.2rem;
            font-weight: 700;
            letter-spacing: 0.02em;
            text-transform: uppercase;
            color: var(--text-white);
        }

        .global-links {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
        }

        .global-links a {
            padding: 8px 14px;
            border-radius: 4px;
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-grey);
            font-size: 0.85rem;
            transition: all 200ms ease;
        }

        .global-links a:hover,
        .global-links a[aria-current="page"] {
            background: rgba(249, 115, 22, 0.2);
            color: var(--text-white);
        }
'@

foreach ($filePath in $files) {
    Write-Output "Updating navigation: $($filePath.Split('\')[-1])"
    
    $content = Get-Content $filePath -Raw
    
    # Replace entire global-nav CSS block
    $content = $content -replace '\/\*\s*Navigation\s*\*\/.*?(?=\s*\/\*|\s*\.hero|\s*\.header|\s*\.page\s*\{|\.story-banner)', $cleanNavCSS
    
    # Update navigation HTML structure
    $content = $content -replace '<nav class="global-nav"[^>]*>\s*<a class="global-brand"', @'
    <nav class="global-nav">
        <div class="nav-container">
            <a class="global-brand"
'@
    
    $content = $content -replace '</a>\s*<div class="global-links">', @'
</a>
            <div class="global-links">
'@
    
    $content = $content -replace '</div>\s*</nav>', @'
</div>
        </div>
    </nav>
'@
    
    # Remove responsive nav styles that reference old structure
    $content = $content -replace '@media\s*\(max-width:\s*900px\)\s*\{[^}]*?\.global-nav\s*\{[^}]+\}[^}]*?\.global-links\s*\{[^}]+\}[^}]*?\}', @'
        @media (max-width: 900px) {
            .nav-container {
                flex-direction: column;
                align-items: flex-start;
            }
            .global-links {
                flex-direction: column;
                width: 100%;
            }
        }
'@
    
    # Save updated file
    Set-Content -Path $filePath -Value $content -NoNewline
    
    Write-Output "  âœ" Updated: $($filePath.Split('\')[-1])"
}

Write-Output "`nNavigation update complete!"
