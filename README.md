# Aplikácia na simuláciu portálového žeriava v MATLABe

## Prehľad
Táto aplikácia vytvorená v prostredí MATLAB App Designer poskytuje interaktívne rozhranie na analýzu a simuláciu dynamických systémov s dôrazom na model portálového žeriava. Umožňuje používateľom generovať fázové portréty pre jednoduché dynamické systémy (napr. pružina a tlmič, oscilátor Van der Pola, matematické kyvadlo), vizualizovať fázové trajektórie pre lineárne a nelineárne modely žeriava a simulovať riadenie žeriava pomocou rôznych regulátorov (napr. LQR, riadenie založené na Ljapunovovej funkcii).

Aplikácia je rozdelená do troch hlavných modulov:
1. **Fázové portréty jednoduchých modelov**: Analýza jednoduchých dynamických systémov, ako sú pružina a tlmič, oscilátor Van der Pola a matematické kyvadlo.
2. **Fázové portréty modelu žeriava**: Vizualizácia fázových trajektórií pre lineárny alebo nelineárny model portálového žeriava, s alebo bez motora.
3. **Riadenie modelu portálového žeriava**: Simulácia a hodnotenie stratégií riadenia žeriava pomocou rôznych regulátorov.

## Požiadavky
- **MATLAB**: Verzia R2019b alebo novšia (vyžaduje sa App Designer).
- **MATLAB Toolboxes**:
  - Control System Toolbox (pre LQR a iné metódy riadenia).
  - Symbolic Math Toolbox (voliteľné, pre určité výpočty modelu).
- Odporúča sa základné porozumenie dynamických systémov a teórie riadenia.

## Inštalácia
1. Naklonujte tento repozitár na váš lokálny počítač:
   ```bash
   git clone https://github.com/your-username/portal-crane-simulation.git
2. Otvorte MATLAB a prejdite do adresára projektu:
   ```bash
   cd cesta/k/portal-crane-simulation
3. Otvorte hlavný súbor aplikácie (PortalCraneApp.mlapp) v MATLAB App Designer:
   ```bash
   appdesigner('PortalCraneApp.mlapp')
4. Uistite sa, že máte nainštalované všetky požadované MATLAB toolboxes.

## Používanie
1. Spustenie aplikácie:
   - Spustite aplikáciu z MATLAB App Designer kliknutím na tlačidlo „Spustiť“ alebo priamo vykonajte súbor .mlapp v MATLABe.
2. Hlavné menu:
   - Hlavné menu ponúka tri možnosti:
     - Fázové portréty jednoduchých modelov: Vyberte model (napr. Pružina a tlmič) a nastavte parametre, ako sú hmotnosť (m), koeficient tlmenia (c), tuhosť pružiny (k), počiatočné podmienky a budenie (u).
     - Fázové portréty modelu žeriava: Vyberte medzi lineárnym alebo nelineárnym modelom žeriava, s motorom alebo bez neho. Nastavte parametre, ako sú hmotnosť vozíka (m0), hmotnosť bremena (m1), dĺžka lana (l)       a parametre motora (ak sú relevantné).
     - Riadenie modelu portálového žeriava: Vyberte regulátor (napr. LQR alebo riadenie založené na Ljapunovovej funkcii) a simulujte správanie žeriava, pričom vizualizujete polohu vozíka a uhol vychýlenia bremena.
3. Simulácia:
   - Nastavte parametre v grafickom rozhraní a kliknite na „Simulácia“ pre spustenie simulácie.
   - Výsledky (napr. fázové portréty, grafy riadenia) sa zobrazia v rozhraní aplikácie alebo v samostatných oknách v závislosti od modulu.
4. Príklad:
   - Na vygenerovanie fázového portrétu pre model Pružina a tlmič:
     - Vyberte „Fázové portréty jednoduchých modelov“ z hlavného menu.
     - Vyberte model „Pružina a tlmič“.
     - Nastavte parametre (napr. m = 1 kg, c = 0.5, k = 1, počiatočné podmienky x(0) = 1, dx/dt(0) = 0).
     - Vyberte metódu tvorby fázového portrétu (Vetva A alebo Vetva B).
     - Kliknite na „Simulácia“ pre zobrazenie fázového portrétu.
