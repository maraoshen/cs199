function [ rainWaterConversionMatrix ] = RainConversion()
    angatArea = 117277646.117;
    rainWaterConversionMatrix = {};
    for i = 1:800
        rainWaterConversionMatrix = vertcat(rainWaterConversionMatrix, i*angatArea);
    end
end