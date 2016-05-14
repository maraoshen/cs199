function [ angatDam, ipoDam, lamesaDam, xMatrix] = WaterModel( )
%WATERMODEL Summary of this function goes here
%   Detailed explanation goes here

    angatArea = 117277646.117;
    ipoArea = 12328865.709;
    lamesaArea = 8875612.148;
    
    rainMatrix = readFile('new_rainfall.csv');
    years = size(rainMatrix);
    disp(rainMatrix);
    initAngatWater = 504 * 1000000 * 1000;
    initIpoWater = 450 * 1000000 * 1000;
    initLaMesaWater = 330 * 1000000 * 1000;
    
    xMatrix = createXValues(1, 12, years);
    initDamLevels();
    [angatDam ipoDam lamesaDam ] = simulate(years, initAngatWater, initIpoWater, initLaMesaWater, angatArea, ipoArea, lamesaArea, rainMatrix);
end

function initDamLevels ()

% == GLOBAL VARIABLES == %
    global angatCapacity;
    global angatNormal;
    global angatCritical;
    angatCapacity = 738 * 1000000 * 1000; % 212 is spilling level
    angatNormal = 696 * 1000000 * 1000;%504 * 1000000 * 1000; % 200 is normal level
    angatCritical = 206 * 1000000 * 1000; % 180 is critical level
    
    global ipoCapacity;
    global ipoNormal;
    global ipoCritical;
    %ipoCapacity = 70 * 70 * 105;
    %ipoNormal = 70 * 70 * 101; % 101 is normal level
    %ipoCritical = 70 * 70;
    ipoCapacity = 700 * 1000000 * 1000;
    ipoNormal = 470 * 1000000 * 1000; % 101 is normal level
    ipoCritical = 300 * 1000000 * 1000;
    
    global lamesaCapacity;
    global lamesaNormal;
    global lamesaCritical;
    %lamesaCapacity = 27 * 27 * 82;
    %lamesaNormal = 27 * 27 * 80.15; %80.15 is normal level
    %lamesaCritical = 27 * 27;
    lamesaCapacity = 530 * 1000000 * 1000;
    lamesaNormal = 330 * 1000000 * 1000; %80.15 is normal level
    lamesaCritical = 230 * 1000000 * 1000;

% ---------------------- %
end

function value = damCapacity (choice)
   global angatCapacity;
   global ipoCapacity;
   global lamesaCapacity;
   if choice == 1 %angat
       value = angatCapacity;
   elseif choice == 2 %ipo
       value = ipoCapacity;
   else %lamesa
       value = lamesaCapacity;
   end
end

function value = damNormal (choice)
   global angatNormal;
   global ipoNormal;
   global lamesaNormal;
   if choice == 1 %angat
       value = angatNormal;
   elseif choice == 2 %ipo
       value = ipoNormal;
   else %lamesa
       value = lamesaNormal;
   end
end

function value = damCritical (choice)
   global angatCritical;
   global ipoCritical;
   global lamesaCritical;
   if choice == 1 %angat
       value = angatCritical;
   elseif choice == 2 %ipo
       value = ipoCritical;
   else %lamesa
       value = lamesaCritical;
   end
end

function [ newWater, transfer, overflow ] = compute( prevWater, naturalLoss, rainfall, loss, transferred, damChoice )
    % 0 muna ang loss for now. Should be controlled values.
    newWater = prevWater + rainfall + transferred - naturalLoss - loss;
    
    if newWater > damCapacity(damChoice)
        if damChoice == 1
            disp('a');
        end
        overflow = newWater - damCapacity(damChoice);
        transfer = overflow;
        newWater = damCapacity(damChoice);
%         disp(overflow);
    elseif newWater > damNormal(damChoice)
        %disp('b');
        overflow = 0;
        transfer = newWater - damNormal(damChoice);
        newWater = damNormal(damChoice);
    elseif newWater > damCritical(damChoice)
        %disp('c');
        overflow = 0;
        transfer = (newWater - damCritical(damChoice))/2;
        newWater = damCritical(damChoice) + transfer;
    else
        %disp('d');
        overflow = 0;
        transfer = 0;
    end
    if damChoice == 1
        disp(newWater);
        disp(overflow); 
    end
    %disp([newWater, transfer, overflow]);
end


function [ angatDam, ipoDam, lamesaDam ] = simulate( years, initAngatWater, initIpoWater, initLaMesaWater, angatArea, ipoArea, lamesaArea, rainMatrix )    
    prevAWater = initAngatWater;
    prevIWater = initIpoWater;
    prevLMWater = initLaMesaWater;
    
    angatWater = {};
    angatTransfer = {};
    angatOverflow = {};
    
    ipoWater = {};
    ipoTransfer = {};
    ipoOverflow = {};
    
    lamesaWater = {};
    lamesaTransfer = {};
    lamesaOverflow = {};
    
    for i = 1:years
        
        a1 = {};
        a2 = {};
        a3 = {};
        i1 = {};
        i2 = {};
        i3 = {};
        lm1 = {};
        lm2 = {};
        lm3 = {};
        for j = 1:12
            value1 = 0;
            value2 = 0;
            value3 = 0;
            [value1, value2, value3] = compute(prevAWater, getNaturalLoss(prevAWater), getRainWater(angatArea, rainMatrix(i,j)), 0, 0, 1);
            disp('value3');
            disp(value3);
            %disp('Angat');
            %disp([value1 value2 value3]);
            a1 = [a1; value1];
            a2 = [a2; value2];
            a3 = [a3; value3];
            transferValue = value2;
            prevAWater = value1;
            
            
            [value1 value2 value3] = compute(prevIWater, getNaturalLoss(prevIWater), getRainWater(ipoArea, rainMatrix(i,j)), 0, transferValue, 2);
            i1 = [i1; value1];
            i2 = [i2; value2];
            i3 = [i3; value3];
            transferValue = value2;
            prevIWater = value1;
            %disp('Ipo');
            %disp([value1 value2 value3]);
            
            [value1 value2 value3] = compute(prevLMWater, getNaturalLoss(prevLMWater), getRainWater(lamesaArea, rainMatrix(i,j)), 0, transferValue, 3);
            lm1 = [lm1; value1];
            lm2 = [lm2; value2];
            lm3 = [lm3; value3];
            prevLMWater = value1;
            %disp('La Mesa');
            %disp([value1 value2 value3]);
        end
        angatWater = horzcat(angatWater, a1);
        angatTransfer = horzcat(angatTransfer, a2);
        angatOverflow = horzcat(angatOverflow, a3);
        ipoWater = horzcat(ipoWater, i1);
        ipoTransfer = horzcat(ipoTransfer, i2);
        ipoOverflow = horzcat(ipoOverflow, i3);
        lamesaWater = horzcat(lamesaWater, lm1);
        lamesaTransfer = horzcat(lamesaTransfer, lm2);
        lamesaOverflow = horzcat(lamesaOverflow, lm3);
    end
    
    angatDam = {};
    angatDam(:, :, 1) = angatWater;
    angatDam(:, :, 2) = angatTransfer;
    angatDam(:, :, 3) = angatOverflow;
    disp('Angat');
    disp(angatDam);
    ipoDam = {};
    ipoDam(:, :, 1) = ipoWater;
    ipoDam(:, :, 2) = ipoTransfer;
    ipoDam(:, :, 3) = ipoOverflow;
    disp('Ipo');
    disp(ipoDam);
    lamesaDam = {};
    lamesaDam(:, :, 1) = lamesaWater;
    lamesaDam(:, :, 2) = lamesaTransfer;
    lamesaDam(:, :, 3) = lamesaOverflow;
    disp('La Mesa');
    disp(lamesaDam);
end


function [ totalLoss ] = getNaturalLoss( waterLevel )
    seepingCoeff = 0;
    evaporationCoeff = 0;
    
    totalLoss = seepingCoeff * waterLevel + evaporationCoeff * waterLevel;
end

function [ totalRain ] = getRainWater ( area, mm )
    if mm >= 0
        totalRain = area * mm;
    else
        totalRain = 0;
    end
end

function [ rainMatrix ] = readFile (filename)
    rainMatrix = csvread(filename, 1, 1);
    rainMatrix = rainMatrix(1:5, 1:12);
end

function [ xMatrix ] = createXValues (start, years, months)

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