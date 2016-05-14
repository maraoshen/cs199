function [ xMatrix, populationM, waterDemandM angatCapacityM hData x2Matrix angat2] = Simulation(population, growthRate, startYear, years, perCapita, hStart, hEnd, inflowFile, mwssFile, niaFile)
%SIMULATION Summary of this function goes here
%   Detailed explanation goes here
    %{
    disp(population);
    disp(growthRate);
    disp(initialWaterLevel);
    disp(startYear);
    disp(years);
    disp(angatCapacityM);
    disp(populationM);
    %}
    
    xMatrix = createXValues(startYear, years, 12);
    populationM = projectPopulation(population, growthRate, years);
    waterDemandM = getWaterDemand(cell2mat(populationM), perCapita, years);
    angatCapacityM = getAngatCapacity(years);
    [hData x2Matrix] = hSimulate(hStart, hEnd, inflowFile, mwssFile, niaFile);
    angat2 = {};
    angat2 = getCapacityMonth(angat2);
    %disp(populationM);
    % disp(angat2);
    %hData = getCapacityMonth(hData);
    %disp(hData);
    % disp(hData);
end

function [ hData xMatrix ] = hSimulate (hStart, hEnd, inflowFile, mwssFile, niaFile)
    % output cubic meter per second
    [hInflow hRainfall hMWSS hNIA] = readHistoricalData(hStart, hEnd, inflowFile, mwssFile, niaFile);
    years = hEnd - hStart + 1;
    xMatrix = createXValues(1, 12, years);
    hData = {};
    waterLevel = 212^3;
    for i = 1:years
        tempMatrix = {};
        waterLevel = 212^3;
        for j = 1:12
            waterLevel = waterLevel + hInflow(i, j) - hNIA(i, j) - hMWSS(i, j);
            %if hRainfall ~= -1
            %   waterLevel = waterLevel + (hRainfall*0.001*312400); 
            %end
            tempMatrix = [tempMatrix; waterLevel];
        end
        hData = horzcat(hData, tempMatrix);
    end
end

function [ hData ] = getCapacityMonth(hData)
    %capacity = 500000000* 0.0000000438126;
    capacity = 212^3;
    %capacity = 4000 * 1000000 * 0.0115740741; % in cubic meter per second
    tempMatrix = {};
    for j = 1:12
        tempMatrix = [tempMatrix; capacity];
    end
    hData = horzcat(hData, tempMatrix);
end

function [ hInflow, hRainfall, hMWSS, hNIA ] = readHistoricalData(hStart, hEnd, inflowFile, mwssFile, niaFile)
    %disp(exist('inflow.csv', 'file'));
    %disp(hStart);
    %disp(hEnd);
    hInflow = csvread(inflowFile, 1, 1);
    year1 = csvread(inflowFile, 1, 0);
    year1 = year1(1, 1);
    hStart = hStart - year1 + 1;
    hEnd = hEnd - year1 + 1;
    %disp(hInflow);
    %disp(hStart);
    %disp(hEnd);
    
    hInflow = hInflow(hStart:hEnd, 1:12);
    hRainfall = csvread('rainfall.csv', 1, 1);
    hRainfall = hRainfall(hStart:hEnd, 1:12);
    hMWSS = csvread(mwssFile, 1, 1);
    hMWSS = hMWSS(hStart:hEnd, 1:12);
    hNIA = csvread(niaFile, 1, 1);
    hNIA = hNIA(hStart:hEnd, 1:12);
    
    %{
    disp(hInflow);
    disp(hRainfall);
    disp(hMWSS);
    disp(hNIA);
    %}
end

function [ rainfallValue ] = getRainfall(month)
    % returns rainfallValue which is a random number for rainfall value depending on the month
    % input value month is an integer corresponding to months
    % data dependent on existing historical data
    
end

function [ inflowValue ] = getInflow()
    % returns inflowValue which is a random value, kind of depending on the historical data
    % 
    
end

function [ niaValue ] = getNIA(month)
    % returns niaValue which is a random value, kind of depending on the historical data
    % depends on the month, maybe
    
end

function [ mwssValue ] = getMWSS(population)
    % returns mwssValue which is the water demand depending on the population
end

function [ waterDemandMatrix ] = getWaterDemand(populationMatrix, perCapita, years)
    % In cases of MWSS-NIA conflicts, NWRB serves as arbiter and historically, 
    % the basis for allocation for domestic use has been the planning standard 
    % of 0.0029 liters per second per capita or 250 liters per capita per day (PIDS, 1999)
    
    % perYear = perCapita*60*60*24*365;
    perYear = perCapita*60*60*24;
    waterDemandMatrix = {};
    for i = 1:years
        tempMatrix = {};
        for j = 1:12
            waterDemandValue = populationMatrix(i,j) * perYear;
            tempMatrix = [tempMatrix waterDemandValue];
        end
        waterDemandMatrix = vertcat(waterDemandMatrix, tempMatrix);
    end
end

function [ populationMatrix ] = projectPopulation(population, growthRate, years)
    % returns a matrix of population predictions
    % rows = number of months (always 12)
    % columns = years
    % population value is always the same for a year
    
    populationMatrix = {};
    for i = 1:years
        yearMatrix = {};
        for j = 1:12
            yearMatrix = [yearMatrix population];
        end
        populationMatrix = vertcat(populationMatrix, yearMatrix);
        newPop = population + (growthRate*population)*1;
        population = newPop;
    end
end

function [ angatCapacityMatrix ] = getAngatCapacity(years)
    % capacity = 850*(10^6) * 1000;
    % angat supplies 500 million gallons per day
    % 1 gallon = 3.785412 liters
    % capacity = 500000000*3.785412*365;
    
    capacity = 4000*1000000;
    angatCapacityMatrix = {};
    for i = 1:years
        tempMatrix = {};
        for j = 1:12
            tempMatrix = [tempMatrix capacity];
        end
        angatCapacityMatrix = vertcat(angatCapacityMatrix, tempMatrix);
    end
end

function [ xMatrix ] = createXValues (start, years, months)
    % creates the x values for the graph
    % start is the start year
    % years is the number of years the items would be computed.
    % e.g. if start = 2010, years = 15, xMatrix would be [2010 ... 2025]
    
    xMatrix = {};
    tempMatrix = {};
    for i = 1:years
        tempMatrix = {};
        for j = 1:months
           tempMatrix = [tempMatrix start];
        end
        xMatrix = vertcat(xMatrix, tempMatrix);
        start = start + 1;
    end
end

function [ outputMatrix ] = computeWaterLevel(initialWaterLevel)
    % computes for the water level of angat dam given the input values
    
end

function [ nextWaterLevel ] = predictNext( waterLevel, inflow, rain, mwss, nia)
    % computes for the next water level depending on the input
    % returns volume (unit: cubic meter)
    
    nextWaterLevel = waterLevel + inflow + rain - mwss - nia;
end

%=================================================================%

function [ outputMatrix ] = computeValues( waterLevel, inflow, rain, mwss, nia, rows )
    outputMatrix = size(inflow);
    for i = 1:rows
        fprintf('Year %d\n', i);
        for j = 1:12
            outputMatrix(i,j) = waterLevel + inflow(i,j) + rain(i,j) - mwss(i,j) - nia(i,j);
            fprintf( '%f + %f + %f - %f - %f = %f \n', waterLevel, inflow(i,j), rain(i,j), mwss(i,j), nia(i,j) );
        end
    end
end