@testset "DataFrame integration" begin
    LearnBase.getobs(df::DataFrame, idx) = df[idx,:]
    StatsBase.nobs(df::DataFrame) = nrow(df)

    @testset "targets" begin
        y = [:a,:a,:b,:a,:b]
        df = DataFrame(x1 = rand(5), x2 = rand(5), y = y)
        @test y == targets(row->row.y, df)
    end

    @testset "eachtarget" begin
        y = [:a,:a,:b,:a,:b]
        df = DataFrame(x1 = rand(5), x2 = rand(5), y = y)
        iter = eachtarget(row->row.y, df)
        @test y == collect(iter)
    end

    @testset "gettarget" begin
        LearnBase.gettarget(col::Symbol, df::DataFrameRow) = df[col]
        y = [:a,:a,:b,:a,:b]
        df = DataFrame(x1 = rand(5), x2 = rand(5), y = y)
        @test y == targets(:y, df)
    end

    @testset "gettarget default" begin
        LearnBase.gettarget(df::DataFrameRow) = df[end]
        y = [:a,:a,:b,:a,:b]
        df = DataFrame(x1 = rand(5), x2 = rand(5), y = y)
        @test y == targets(df)
    end
end
