function Draw-TradeAlgorithmsMindMap {
    Get-ChildItem "C:\Program Files (x86)\MindFusion\MindFusion.Diagramming for WPF\DotNet6\" -Filter *.dll | ForEach-Object {
        Add-Type -Path $_.FullName
    }
        $diagram = New-Object MindFusion.Diagramming.Wpf.Diagram
    
        $rootNode = New-Object MindFusion.Diagramming.Wpf.TableNode
        #$rootNode.setText("Trade Algorithms")
        #$rootNode.setBrush([System.Windows.Media.Brushes]::LightBlue)
    
        $technicalAnalysisNode = New-Object MindFusion.Diagramming.Wpf.TableNode
        $technicalAnalysisNodeRow = $technicalAnalysisNode.addRow()
        $technicalAnalysisNodeCell = $technicalAnalysisNodeRow.addCell()
        $technicalAnalysisNodeCell.setText("Technical Analysis")
        $technicalAnalysisNode.setBrush([System.Windows.Media.Brushes]::LightGreen)
    
        $fundamentalAnalysisNode = New-Object MindFusion.Diagramming.Wpf.TableNode
        $fundamentalAnalysisNodeRow = $fundamentalAnalysisNode.addRow()
        $fundamentalAnalysisNodeCell = $fundamentalAnalysisNodeRow.addCell()
        $fundamentalAnalysisNodeCell.setText("Fundamental Analysis")
        $fundamentalAnalysisNode.setBrush([System.Windows.Media.Brushes]::LightGreen)
    
        $quantitativeAnalysisNode = New-Object MindFusion.Diagramming.Wpf.TableNode
        $quantitativeAnalysisNodeRow = $quantitativeAnalysisNode.addRow()
        $quantitativeAnalysisNodeCell = $quantitativeAnalysisNodeRow.addCell()
        $quantitativeAnalysisNodeCell.setText("Quantitative Analysis")
        $quantitativeAnalysisNode.setBrush([System.Windows.Media.Brushes]::LightGreen)
    
        $machineLearningNode = New-Object MindFusion.Diagramming.Wpf.Node
        $machineLearningNode.setText("Machine Learning")
        $machineLearningNode.setBrush([System.Windows.Media.Brushes]::LightPink)
    
        $rootNode.addChild($technicalAnalysisNode)
        $rootNode.addChild($fundamentalAnalysisNode)
        $rootNode.addChild($quantitativeAnalysisNode)
        $quantitativeAnalysisNode.addChild($machineLearningNode)
    
        $diagram.setMeasurementUnit([MindFusion.Diagramming.MeasurementUnits]::Pixel)
        $diagram.setBounds(0, 0, 800, 600)
        #$diagram.setAutoResizeDrawing(true)
    
        $diagram.addItem($rootNode, 100, 100)
    
        $window = New-Object System.Windows.Window
        $window.Content = $diagram
        $window.Title = "Trade Algorithms Mind Map"
        $window.ShowDialog() | Out-Null
    }
    
    Draw-TradeAlgorithmsMindMap
    
    
    