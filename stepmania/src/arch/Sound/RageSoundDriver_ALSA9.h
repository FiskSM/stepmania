#ifndef RAGE_SOUND_ALSA9
#define RAGE_SOUND_ALSA9

#include "RageSound.h"
#include "RageThreads.h"
#include "RageSoundDriver.h"

#include "ALSA9Helpers.h"

class RageSound_ALSA9: public RageSoundDriver
{
private:
	struct sound
	{
		RageSound *snd;
		bool stopping;
		int flush_pos; /* state == STOPPING only */
		sound() { snd = NULL; stopping=false; }
	};

	/* List of currently playing sounds: */
	vector<sound *> sounds;

	bool shutdown;

	Alsa9Buf *pcm;

	static int MixerThread_start(void *p);
	void MixerThread();
	RageThread MixingThread;

	void GetData();

public:
	/* virtuals: */
	void StartMixing(RageSound *snd);
	void StopMixing(RageSound *snd);
	int GetPosition(const RageSound *snd) const;
	float GetPlayLatency() const;

	void Update(float delta);

	RageSound_ALSA9();
	~RageSound_ALSA9();
};

#endif

/*
 * Copyright (c) 2003 by the person(s) listed below.  All rights reserved.
 *
 * Glenn Maynard
 * 
 * 2003-02   Modified to fake playing sound   Aaron VonderHaar
 * 
 */
