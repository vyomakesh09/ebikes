import { z } from 'zod'

export const userSchema = z.object({
  email: z.string().email(),
  name: z.string().min(2).max(50).optional(),
})

export type UserInput = z.infer<typeof userSchema> 