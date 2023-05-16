function drawOneGraph!(
    chart,
    row :: Int,
    col :: Int,
    subtitle :: String,
    data :: AbstractDataFrame,
    targets :: Vector{String} )
    axd = Axis( # = layout[1,1] 
        chart[row,col], 
        title="Volunteering in Last Month",
        subtitle=subtitle,
        xlabel="Year", 
        ylabel="%" )
    ylims!( axd, [0,100.0])
    plots = []
    for t in targets
        l = lines!( 
            axd,
            data.year,
            data[!,Symbol(t)])
        push!( plots, l )
    end
    leg = Legend(
        chart[row,col+1], 
        plots,
        targets );
    chart
end