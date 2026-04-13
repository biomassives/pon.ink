// 16-BAR SAMPLER ENGINE
// Tonight: Logic for loading external URL samples into AudioBuffers.
import { ref } from 'vue';
import { useAudioEngine } from './useAudioEngine';

export const useSampler = () => {
  const { audioCtx, masterGain } = useAudioEngine();
  const samples = ref<Map<number, AudioBuffer>>(new Map());

  const loadSample = async (padIndex: number, url: string) => {
    if (!audioCtx.value) return;
    const response = await fetch(url);
    const arrayBuffer = await response.arrayBuffer();
    const audioBuffer = await audioCtx.value.decodeAudioData(arrayBuffer);
    samples.value.set(padIndex, audioBuffer);
  };

  const triggerPad = (padIndex: number) => {
    if (!audioCtx.value || !masterGain.value || !samples.value.has(padIndex)) return;
    const source = audioCtx.value.createBufferSource();
    source.buffer = samples.value.get(padIndex)!;
    source.connect(masterGain.value);
    source.start(0);
  };

  return { loadSample, triggerPad, samples };
};
