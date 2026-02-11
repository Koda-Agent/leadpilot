import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

export type WaitlistEntry = {
  id?: string
  name: string
  email: string
  business_name: string
  phone?: string
  message?: string
  source?: string
  created_at?: string
  contacted?: boolean
  contacted_at?: string
}
