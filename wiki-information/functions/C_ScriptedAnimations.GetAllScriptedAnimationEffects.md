## Title: C_ScriptedAnimations.GetAllScriptedAnimationEffects

**Content:**
Needs summary.
`scriptedAnimationEffects = C_ScriptedAnimations.GetAllScriptedAnimationEffects()`

**Returns:**
- `scriptedAnimationEffects`
  - *ScriptedAnimationEffect*
    - `Field`
    - `Type`
    - `Description`
    - `id`
      - *number*
    - `visual`
      - *number*
    - `visualScale`
      - *number*
    - `duration`
      - *number*
    - `trajectory`
      - *Enum.ScriptedAnimationTrajectory*
    - `yawRadians`
      - *number*
    - `pitchRadians`
      - *number*
    - `rollRadians`
      - *number*
    - `offsetX`
      - *number*
    - `offsetY`
      - *number*
    - `offsetZ`
      - *number*
    - `animation`
      - *number*
    - `animationSpeed`
      - *number*
    - `alpha`
      - *number*
    - `useTargetAsSource`
      - *boolean*
    - `startBehavior`
      - *Enum.ScriptedAnimationBehavior?*
    - `startSoundKitID`
      - *number?*
    - `finishEffectID`
      - *number?*
    - `finishBehavior`
      - *Enum.ScriptedAnimationBehavior?*
    - `finishSoundKitID`
      - *number?*
    - `startAlphaFade`
      - *number?*
    - `startAlphaFadeDuration`
      - *number?*
    - `endAlphaFade`
      - *number?*
    - `endAlphaFadeDuration`
      - *number?*
    - `animationStartOffset`
      - *number?*
    - `loopingSoundKitID`
      - *number?*
    - `particleOverrideScale`
      - *number?*

**Enum.ScriptedAnimationTrajectory**
- `Value`
- `Field`
- `Description`
  - `0`
    - AtSource
  - `1`
    - AtTarget
  - `2`
    - Straight
  - `3`
    - CurveLeft
  - `4`
    - CurveRight
  - `5`
    - CurveRandom
  - `6`
    - HalfwayBetween

**Enum.ScriptedAnimationBehavior**
- `Value`
- `Field`
- `Description`
  - `0`
    - None
  - `1`
    - TargetShake
  - `2`
    - TargetKnockBack
  - `3`
    - SourceRecoil
  - `4`
    - SourceCollideWithTarget
  - `5`
    - UIParentShake